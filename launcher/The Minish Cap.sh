#!/bin/bash
unset TMC_P11_TRACE TMC_P11_TRACE_PATH TMC_PROFILE TMC_AUDIO_TRACE TMC_PACE_LOG
export TMC_RENDER_THREADS=3

XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}

if [ -n "${PORTMASTER_CONTROLFOLDER_OVERRIDE:-}" ]; then
  controlfolder="$PORTMASTER_CONTROLFOLDER_OVERRIDE"
elif [ -d "/opt/system/Tools/PortMaster/" ]; then
  controlfolder="/opt/system/Tools/PortMaster"
elif [ -d "/opt/tools/PortMaster/" ]; then
  controlfolder="/opt/tools/PortMaster"
elif [ -d "$XDG_DATA_HOME/PortMaster/" ]; then
  controlfolder="$XDG_DATA_HOME/PortMaster"
else
  controlfolder="/roms/ports/PortMaster"
fi

if [ ! -f "$controlfolder/control.txt" ]; then
  echo "PortMaster control.txt not found: $controlfolder/control.txt"
  exit 10
fi

source "$controlfolder/control.txt"
[ -f "${controlfolder}/mod_${CFW_NAME}.txt" ] && source "${controlfolder}/mod_${CFW_NAME}.txt"
get_controls

GAMEDIR="/$directory/ports/minishcap"
BINARY="tmc_pc.${DEVICE_ARCH}"

cd "$GAMEDIR" || exit 11
> "$GAMEDIR/log.txt" && exec > >(tee "$GAMEDIR/log.txt") 2>&1

export LD_LIBRARY_PATH="$GAMEDIR/libs.${DEVICE_ARCH}:${LD_LIBRARY_PATH:-}"
export SDL_GAMECONTROLLERCONFIG="${sdl_controllerconfig:-}"
export TMC_AUTOPLAY=1
export TMC_DISABLE_UPDATE_CHECK=1
export TMC_RG34XX_SEAMLESS=1
export TMC_RG34XX_HIGH_REFRESH_2X=1
export TMC_RG34XX_A53_AUDIO=1
export SDL_AUDIO_DEVICE_SAMPLE_FRAMES=1600
echo "RG34XX_AUDIO_RESAMPLER=LINEAR_A53_POLICY"
echo "RG34XX_AUDIO_BUFFER_FRAMES=1920"
echo "RG34XX_PROFILE=P13.1.RC1_PROFILE_DRIVEN_CLEAN_CPUCAP936_GPU420_AUDIO1600_RT3_119HZ"
echo "RG34XX_DIAGNOSTICS=OFF"
echo "RG34XX_P11_POLICY=P11.2_VSYNC_OFF_PLUS_P11.4_SINGLE_PRESENT_PLUS_P11.5_AUDIO1600_PLUS_P11.6.3_FAILSAFE_CPUCAP1416_CLEAN_BINARY"
echo "RG34XX_EXIT_FINALIZATION=EXPLICIT_SHUTDOWN_THEN__EXIT"
echo "RG34XX_FILESELECT_LEGACY_L_SETTINGS=DISABLED"
echo "RG34XX_GAME_TPS=59.7275"
echo "RG34XX_DISPLAY_TARGET_HZ=119.455"
echo "RG34XX_OS_EXIT=MENU+L2"
echo "RG34XX_SETTINGS=MENU+R2"

GAME_SDL_VIDEODRIVER=""
if [ -n "${SDL_VIDEODRIVER:-}" ]; then
  export SDL3SHIM_SDL2_VIDEODRIVER="$SDL_VIDEODRIVER"
  GAME_SDL_VIDEODRIVER="sdl2"
fi

GAME_SDL_AUDIODRIVER=""
if [ -n "${SDL_AUDIODRIVER:-}" ]; then
  export SDL3SHIM_SDL2_AUDIODRIVER="$SDL_AUDIODRIVER"
  GAME_SDL_AUDIODRIVER="sdl2"
fi

# The SDL3->SDL2 video backend provides GLES context management and a software
# framebuffer. Do not let SDL3 choose an incompatible renderer class first.
# Prefer GLES2 for hardware acceleration and retain software as a deterministic
# fallback. TMC itself already uses this exact preference list on Android.
if [ "$GAME_SDL_VIDEODRIVER" = "sdl2" ]; then
  export SDL_RENDER_DRIVER="opengles2,software"
fi

if [ ! -f "$GAMEDIR/baserom.gba" ]; then
  pm_message "Missing baserom.gba in $GAMEDIR"
  pm_finish
  exit 12
fi

if command -v sha1sum >/dev/null 2>&1; then
  ROM_SHA1="$(sha1sum "$GAMEDIR/baserom.gba" | awk '{print $1}')"
  if [ "$ROM_SHA1" != "cff199b36ff173fb6faf152653d1bccf87c26fb7" ]; then
    pm_message "Unsupported baserom.gba. This private test package expects the clean EU ROM."
    pm_finish
    exit 13
  fi
fi

if [ ! -x "$GAMEDIR/$BINARY" ]; then
  ${ESUDO:-} chmod +x "$GAMEDIR/$BINARY"
fi

if [ "${TMC_PORTMASTER_TEST_DIAGNOSTICS:-0}" = "1" ]; then
  echo "=== PACKAGE LDD ==="
  ldd "$GAMEDIR/$BINARY" 2>&1 || true
  echo "=== PACKAGE ENV ==="
  echo "CFW_NAME=${CFW_NAME:-}"
  echo "DEVICE_ARCH=${DEVICE_ARCH:-}"
  echo "DISPLAY_WIDTH=${DISPLAY_WIDTH:-}"
  echo "DISPLAY_HEIGHT=${DISPLAY_HEIGHT:-}"
  echo "SDL2_VIDEO_SOURCE=${SDL3SHIM_SDL2_VIDEODRIVER:-}"
  echo "SDL2_AUDIO_SOURCE=${SDL3SHIM_SDL2_AUDIODRIVER:-}"
  echo "SDL_RENDER_DRIVER=${SDL_RENDER_DRIVER:-}"
  if [ "$GAME_SDL_VIDEODRIVER" = "sdl2" ]; then
    echo "RENDER_POLICY=SDL_RENDER_DRIVER=opengles2,software"
  fi
fi

pm_platform_helper "$GAMEDIR/$BINARY"

# ---------------------------------------------------------------------------
# RG34XX seamless display wrapper.
# The boot package remains untouched. Capture the exact live fbset timing,
# switch temporarily to the P10.2.1-validated 119.455-Hz mode, and restore
# the captured timing on normal exit, signal, crash return, or watchdog.
# ---------------------------------------------------------------------------
RG_DISPLAY_RESTORE="/tmp/minishcap-p10.3-display-restore.$$"
RG_DISPLAY_WATCHDOG=""

rg34xx_stop_watchdog() {
    if [ -n "${RG_DISPLAY_WATCHDOG:-}" ]; then
        kill "$RG_DISPLAY_WATCHDOG" 2>/dev/null || true
        wait "$RG_DISPLAY_WATCHDOG" 2>/dev/null || true
        RG_DISPLAY_WATCHDOG=""
    fi
}

rg34xx_restore_display() {
    if [ -x "$RG_DISPLAY_RESTORE" ]; then
        "$RG_DISPLAY_RESTORE" >/dev/null 2>&1 || true
    fi
}

rg34xx_cleanup_display() {
    rg34xx_restore_display
    rg34xx_stop_watchdog
    rm -f "$RG_DISPLAY_RESTORE" 2>/dev/null || true
}
trap rg34xx_cleanup_display EXIT INT TERM HUP

RG_FB="$(fbset -s 2>/dev/null || true)"
RG_GEOM="$(printf '%s\n' "$RG_FB" | awk '/^[[:space:]]*geometry /{print $2,$3,$4,$5,$6;exit}')"
RG_TIME="$(printf '%s\n' "$RG_FB" | awk '/^[[:space:]]*timings /{print $2,$3,$4,$5,$6,$7,$8;exit}')"

RG_REFRESH_OK=0
if [ -n "$RG_GEOM" ] && [ -n "$RG_TIME" ]; then
    set -- $RG_GEOM
    RG_X="$1"; RG_Y="$2"; RG_VX="$3"; RG_VY="$4"; RG_BPP="$5"
    set -- $RG_TIME
    RG_PPS="$1"; RG_LEFT="$2"; RG_RIGHT="$3"; RG_UPPER="$4"; RG_LOWER="$5"; RG_HSLEN="$6"; RG_VSLEN="$7"

    cat > "$RG_DISPLAY_RESTORE" <<EOF
#!/bin/sh
fbset -g $RG_X $RG_Y $RG_VX $RG_VY $RG_BPP -t $RG_PPS $RG_LEFT $RG_RIGHT $RG_UPPER $RG_LOWER $RG_HSLEN $RG_VSLEN
EOF
    chmod 700 "$RG_DISPLAY_RESTORE"

    RG_VTOTAL=$((RG_Y + RG_UPPER + RG_LOWER + RG_VSLEN))
    RG_NEW_RIGHT=$((843 - RG_X - RG_LEFT - RG_HSLEN))

    if [ "$RG_X" -eq 720 ] && [ "$RG_Y" -eq 480 ] &&
       [ "$RG_VX" -eq 720 ] && [ "$RG_VY" -eq 960 ] &&
       [ "$RG_BPP" -eq 32 ] && [ "$RG_VTOTAL" -eq 536 ] &&
       [ "$RG_NEW_RIGHT" -gt 0 ]; then

        fbset -g "$RG_X" "$RG_Y" "$RG_VX" "$RG_VY" "$RG_BPP" \
              -t 18527 "$RG_LEFT" "$RG_NEW_RIGHT" \
                 "$RG_UPPER" "$RG_LOWER" "$RG_HSLEN" "$RG_VSLEN"

        RG_ACTIVE="$(fbset -s 2>/dev/null || true)"
        RG_HZ="$(printf '%s\n' "$RG_ACTIVE" |
                 awk '/#[[:space:]]*D:/{for(i=1;i<=NF;i++) if($i=="V:"){print $(i+1);exit}}')"
        if [ -n "$RG_HZ" ] &&
           awk -v v="$RG_HZ" 'BEGIN{exit !(v>=119.3 && v<=119.6)}'; then
            RG_REFRESH_OK=1
            echo "RG34XX_REFRESH_ACTIVE_HZ=$RG_HZ"
        fi
    fi
fi

if [ "$RG_REFRESH_OK" -ne 1 ]; then
    echo "RG34XX_REFRESH_FALLBACK=60_HZ"
    export TMC_RG34XX_HIGH_REFRESH_2X=0
    rg34xx_restore_display
else
    # If the launcher itself disappears unexpectedly, restore the exact
    # captured timing independently of its EXIT trap.
    RG_LAUNCHER_PID=$$
    (
        while kill -0 "$RG_LAUNCHER_PID" 2>/dev/null; do
            sleep 1
        done
        "$RG_DISPLAY_RESTORE" >/dev/null 2>&1 || true
        rm -f "$RG_DISPLAY_RESTORE" 2>/dev/null || true
    ) &
    RG_DISPLAY_WATCHDOG=$!
fi

EXTRA_ARGS=""
[ "${TMC_PORTMASTER_TEST_NO_AUDIO:-0}" = "1" ] && EXTRA_ARGS="--no-audio"

SDL_VIDEODRIVER="$GAME_SDL_VIDEODRIVER" \
SDL_AUDIODRIVER="$GAME_SDL_AUDIODRIVER" \
# P11.6.3 RG34XX: fail-safe game-lifetime CPU max cap.
# Policy drift falls back to stock clocks instead of mutating an unknown state.
RG34XX_CPU_POLICY="/sys/devices/system/cpu/cpufreq/policy0"
RG34XX_CPU_EXPECTED_MAX_KHZ="1512000"
RG34XX_CPU_EXPECTED_MIN_KHZ="480000"
RG34XX_CPU_EXPECTED_GOVERNOR="ondemand"
RG34XX_CPU_CAP_KHZ="936000"
RG34XX_CPU_ORIG_MAX_KHZ=""
RG34XX_CPU_CAP_APPLIED="0"
RG34XX_CPU_WATCHDOG_PID=""

rg34xx_cpu_cap_restore() {
  rg34xx_restore_rc=0

  if [ -n "${RG34XX_CPU_WATCHDOG_PID:-}" ]; then
    kill "$RG34XX_CPU_WATCHDOG_PID" >/dev/null 2>&1 || true
    wait "$RG34XX_CPU_WATCHDOG_PID" >/dev/null 2>&1 || true
    RG34XX_CPU_WATCHDOG_PID=""
  fi

  if [ "${RG34XX_CPU_CAP_APPLIED:-0}" = "1" ]; then
    if [ -w "$RG34XX_CPU_POLICY/scaling_max_freq" ] && [ -n "${RG34XX_CPU_ORIG_MAX_KHZ:-}" ]; then
      printf '%s\n' "$RG34XX_CPU_ORIG_MAX_KHZ" > "$RG34XX_CPU_POLICY/scaling_max_freq" || rg34xx_restore_rc=1
      RG34XX_CPU_RESTORED_NOW="$(cat "$RG34XX_CPU_POLICY/scaling_max_freq" 2>/dev/null || true)"
      if [ "$RG34XX_CPU_RESTORED_NOW" = "$RG34XX_CPU_ORIG_MAX_KHZ" ]; then
        echo "RG34XX_CPU_MAX_RESTORE=PASS:$RG34XX_CPU_RESTORED_NOW"
      else
        echo "RG34XX_CPU_MAX_RESTORE=FAIL:${RG34XX_CPU_RESTORED_NOW:-UNREADABLE}"
        rg34xx_restore_rc=1
      fi
    else
      echo "RG34XX_CPU_MAX_RESTORE=FAIL:POLICY_UNWRITABLE"
      rg34xx_restore_rc=1
    fi
    RG34XX_CPU_CAP_APPLIED="0"
  fi

  return "$rg34xx_restore_rc"
}

rg34xx_cpu_cap_signal() {
  rg34xx_signal_rc="$1"
  rg34xx_cpu_cap_restore || true
  trap - EXIT INT TERM HUP
  exit "$rg34xx_signal_rc"
}

rg34xx_cpu_cap_prepare() {
  if [ ! -r "$RG34XX_CPU_POLICY/scaling_max_freq" ] ||
     [ ! -w "$RG34XX_CPU_POLICY/scaling_max_freq" ] ||
     [ ! -r "$RG34XX_CPU_POLICY/scaling_min_freq" ] ||
     [ ! -r "$RG34XX_CPU_POLICY/scaling_governor" ]; then
    echo "RG34XX_CPU_CAP_MODE=FALLBACK_STOCK:POLICY_UNAVAILABLE"
    return 0
  fi

  RG34XX_CPU_ORIG_MAX_KHZ="$(cat "$RG34XX_CPU_POLICY/scaling_max_freq" 2>/dev/null || true)"
  RG34XX_CPU_MIN_NOW="$(cat "$RG34XX_CPU_POLICY/scaling_min_freq" 2>/dev/null || true)"
  RG34XX_CPU_GOV_NOW="$(cat "$RG34XX_CPU_POLICY/scaling_governor" 2>/dev/null || true)"

  if [ "$RG34XX_CPU_ORIG_MAX_KHZ" != "$RG34XX_CPU_EXPECTED_MAX_KHZ" ] ||
     [ "$RG34XX_CPU_MIN_NOW" != "$RG34XX_CPU_EXPECTED_MIN_KHZ" ] ||
     [ "$RG34XX_CPU_GOV_NOW" != "$RG34XX_CPU_EXPECTED_GOVERNOR" ]; then
    echo "RG34XX_CPU_CAP_MODE=FALLBACK_STOCK:POLICY_DRIFT:max=$RG34XX_CPU_ORIG_MAX_KHZ:min=$RG34XX_CPU_MIN_NOW:gov=$RG34XX_CPU_GOV_NOW"
    return 0
  fi

  if [ -r "$RG34XX_CPU_POLICY/scaling_available_frequencies" ] &&
     ! grep -qw "$RG34XX_CPU_CAP_KHZ" "$RG34XX_CPU_POLICY/scaling_available_frequencies"; then
    echo "RG34XX_CPU_CAP_MODE=FALLBACK_STOCK:CAP_NOT_SELECTABLE"
    return 0
  fi

  if ! printf '%s\n' "$RG34XX_CPU_CAP_KHZ" > "$RG34XX_CPU_POLICY/scaling_max_freq"; then
    echo "RG34XX_CPU_CAP_MODE=FALLBACK_STOCK:CAP_WRITE_FAILED"
    return 0
  fi

  RG34XX_CPU_ACTIVE_MAX="$(cat "$RG34XX_CPU_POLICY/scaling_max_freq" 2>/dev/null || true)"
  if [ "$RG34XX_CPU_ACTIVE_MAX" != "$RG34XX_CPU_CAP_KHZ" ]; then
    printf '%s\n' "$RG34XX_CPU_ORIG_MAX_KHZ" > "$RG34XX_CPU_POLICY/scaling_max_freq" 2>/dev/null || true
    echo "RG34XX_CPU_CAP_MODE=FALLBACK_STOCK:CAP_VERIFY_FAILED:$RG34XX_CPU_ACTIVE_MAX"
    return 0
  fi

  RG34XX_CPU_CAP_APPLIED="1"
  echo "RG34XX_CPU_CAP_MODE=ACTIVE"
  echo "RG34XX_CPU_CAP_APPLIED_KHZ=$RG34XX_CPU_ACTIVE_MAX"
  echo "RG34XX_CPU_CAP_RESTORE_TARGET_KHZ=$RG34XX_CPU_ORIG_MAX_KHZ"

  RG34XX_CPU_LAUNCHER_PID="$$"
  (
    while kill -0 "$RG34XX_CPU_LAUNCHER_PID" >/dev/null 2>&1; do
      sleep 1
    done
    RG34XX_WD_NOW="$(cat "$RG34XX_CPU_POLICY/scaling_max_freq" 2>/dev/null || true)"
    if [ "$RG34XX_WD_NOW" = "$RG34XX_CPU_CAP_KHZ" ]; then
      printf '%s\n' "$RG34XX_CPU_ORIG_MAX_KHZ" > "$RG34XX_CPU_POLICY/scaling_max_freq" 2>/dev/null || true
    fi
  ) &
  RG34XX_CPU_WATCHDOG_PID="$!"
  echo "RG34XX_CPU_WATCHDOG=ARMED:$RG34XX_CPU_WATCHDOG_PID"
}

# P13.1.RC1 RG34XX: fail-safe game-lifetime GPU max cap selected by AutoLab.
RG34XX_GPU_NODE="/sys/devices/platform/gpu/devfreq/gpu"
RG34XX_GPU_CAP_HZ="420000000"
RG34XX_GPU_ORIG_MAX_HZ=""
RG34XX_GPU_ORIG_MIN_HZ=""
RG34XX_GPU_ORIG_GOVERNOR=""
RG34XX_GPU_CAP_APPLIED="0"
RG34XX_GPU_WATCHDOG_PID=""

rg34xx_gpu_cap_restore() {
  rg34xx_gpu_restore_rc=0
  if [ -n "${RG34XX_GPU_WATCHDOG_PID:-}" ]; then
    kill "$RG34XX_GPU_WATCHDOG_PID" >/dev/null 2>&1 || true
    wait "$RG34XX_GPU_WATCHDOG_PID" >/dev/null 2>&1 || true
    RG34XX_GPU_WATCHDOG_PID=""
  fi
  if [ "${RG34XX_GPU_CAP_APPLIED:-0}" = "1" ]; then
    if [ -w "$RG34XX_GPU_NODE/max_freq" ] && [ -n "${RG34XX_GPU_ORIG_MAX_HZ:-}" ]; then
      printf '%s\n' "$RG34XX_GPU_ORIG_MAX_HZ" > "$RG34XX_GPU_NODE/max_freq" || rg34xx_gpu_restore_rc=1
      RG34XX_GPU_RESTORED_NOW="$(cat "$RG34XX_GPU_NODE/max_freq" 2>/dev/null || true)"
      if [ "$RG34XX_GPU_RESTORED_NOW" = "$RG34XX_GPU_ORIG_MAX_HZ" ]; then
        echo "RG34XX_GPU_MAX_RESTORE=PASS:$RG34XX_GPU_RESTORED_NOW"
      else
        echo "RG34XX_GPU_MAX_RESTORE=FAIL:${RG34XX_GPU_RESTORED_NOW:-UNREADABLE}"
        rg34xx_gpu_restore_rc=1
      fi
    else
      echo "RG34XX_GPU_MAX_RESTORE=FAIL:POLICY_UNWRITABLE"
      rg34xx_gpu_restore_rc=1
    fi
    RG34XX_GPU_MIN_NOW="$(cat "$RG34XX_GPU_NODE/min_freq" 2>/dev/null || true)"
    RG34XX_GPU_GOV_NOW="$(cat "$RG34XX_GPU_NODE/governor" 2>/dev/null || true)"
    if [ "$RG34XX_GPU_MIN_NOW" = "$RG34XX_GPU_ORIG_MIN_HZ" ] && [ "$RG34XX_GPU_GOV_NOW" = "$RG34XX_GPU_ORIG_GOVERNOR" ]; then
      echo "RG34XX_GPU_POLICY_RESTORE=PASS"
    else
      echo "RG34XX_GPU_POLICY_RESTORE=FAIL:min=$RG34XX_GPU_MIN_NOW:gov=$RG34XX_GPU_GOV_NOW"
      rg34xx_gpu_restore_rc=1
    fi
    RG34XX_GPU_CAP_APPLIED="0"
  fi
  return "$rg34xx_gpu_restore_rc"
}

rg34xx_gpu_cap_prepare() {
  if [ ! -r "$RG34XX_GPU_NODE/max_freq" ] || [ ! -w "$RG34XX_GPU_NODE/max_freq" ] ||
     [ ! -r "$RG34XX_GPU_NODE/min_freq" ] || [ ! -r "$RG34XX_GPU_NODE/governor" ] ||
     [ ! -r "$RG34XX_GPU_NODE/available_frequencies" ]; then
    echo "RG34XX_GPU_CAP_MODE=FALLBACK_STOCK:POLICY_UNAVAILABLE"; return 0
  fi
  RG34XX_GPU_ORIG_MAX_HZ="$(cat "$RG34XX_GPU_NODE/max_freq" 2>/dev/null || true)"
  RG34XX_GPU_ORIG_MIN_HZ="$(cat "$RG34XX_GPU_NODE/min_freq" 2>/dev/null || true)"
  RG34XX_GPU_ORIG_GOVERNOR="$(cat "$RG34XX_GPU_NODE/governor" 2>/dev/null || true)"
  if ! grep -qw "$RG34XX_GPU_CAP_HZ" "$RG34XX_GPU_NODE/available_frequencies"; then echo "RG34XX_GPU_CAP_MODE=FALLBACK_STOCK:CAP_NOT_SELECTABLE"; return 0; fi
  if ! printf '%s\n' "$RG34XX_GPU_CAP_HZ" > "$RG34XX_GPU_NODE/max_freq"; then echo "RG34XX_GPU_CAP_MODE=FALLBACK_STOCK:CAP_WRITE_FAILED"; return 0; fi
  RG34XX_GPU_ACTIVE_MAX="$(cat "$RG34XX_GPU_NODE/max_freq" 2>/dev/null || true)"
  if [ "$RG34XX_GPU_ACTIVE_MAX" != "$RG34XX_GPU_CAP_HZ" ]; then
    printf '%s\n' "$RG34XX_GPU_ORIG_MAX_HZ" > "$RG34XX_GPU_NODE/max_freq" 2>/dev/null || true
    echo "RG34XX_GPU_CAP_MODE=FALLBACK_STOCK:CAP_VERIFY_FAILED:$RG34XX_GPU_ACTIVE_MAX"; return 0
  fi
  RG34XX_GPU_CAP_APPLIED="1"
  echo "RG34XX_GPU_CAP_MODE=ACTIVE"
  echo "RG34XX_GPU_CAP_APPLIED_HZ=$RG34XX_GPU_ACTIVE_MAX"
  echo "RG34XX_GPU_CAP_RESTORE_TARGET_HZ=$RG34XX_GPU_ORIG_MAX_HZ"
  RG34XX_GPU_LAUNCHER_PID="$$"
  (
    while kill -0 "$RG34XX_GPU_LAUNCHER_PID" >/dev/null 2>&1; do sleep 1; done
    RG34XX_GPU_WD_NOW="$(cat "$RG34XX_GPU_NODE/max_freq" 2>/dev/null || true)"
    if [ "$RG34XX_GPU_WD_NOW" = "$RG34XX_GPU_CAP_HZ" ]; then printf '%s\n' "$RG34XX_GPU_ORIG_MAX_HZ" > "$RG34XX_GPU_NODE/max_freq" 2>/dev/null || true; fi
  ) &
  RG34XX_GPU_WATCHDOG_PID="$!"
  echo "RG34XX_GPU_WATCHDOG=ARMED:$RG34XX_GPU_WATCHDOG_PID"
}

rg34xx_final_restore() {
  rg34xx_final_rc=0
  rg34xx_gpu_cap_restore || rg34xx_final_rc=1
  rg34xx_cpu_cap_restore || rg34xx_final_rc=1
  return "$rg34xx_final_rc"
}
rg34xx_final_signal() {
  rg34xx_final_signal_rc="$1"
  rg34xx_final_restore || true
  trap - EXIT INT TERM HUP
  exit "$rg34xx_final_signal_rc"
}
trap 'rg34xx_final_restore || true' EXIT
trap 'rg34xx_final_signal 130' INT
trap 'rg34xx_final_signal 143' TERM
trap 'rg34xx_final_signal 129' HUP

rg34xx_cpu_cap_prepare
rg34xx_gpu_cap_prepare
"$GAMEDIR/$BINARY" --window_scale=3 --console-parity $EXTRA_ARGS
RG34XX_GAME_RC=$?
rg34xx_final_restore || true
echo "RG34XX_GAME_EXIT_RC=$RG34XX_GAME_RC"
RC=$?

rg34xx_restore_display
rg34xx_stop_watchdog
rm -f "$RG_DISPLAY_RESTORE" 2>/dev/null || true
trap - EXIT INT TERM HUP

pm_finish
exit "$RC"
