"""Read-only reanalysis of the named Minish Cap archive; no game execution.
Usage: python reanalyse.py ARCHIVE.zip NEW_OUTPUT_DIRECTORY
"""
import csv, hashlib, io, json, math, sys, zipfile
from pathlib import Path

def sha(b): return hashlib.sha256(b).hexdigest()
def percentile(values, q):
    xs=sorted(values); pos=(len(xs)-1)*q; lo=math.floor(pos); hi=math.ceil(pos)
    return xs[lo]+(xs[hi]-xs[lo])*(pos-lo)
def stats(xs):
    return {'n':len(xs),'mean':sum(xs)/len(xs),'median':percentile(xs,.5),
            'p95':percentile(xs,.95),'max':max(xs),'min':min(xs)}
def run(archive, out):
    out.mkdir(parents=True, exist_ok=False)
    with zipfile.ZipFile(archive) as z:
        prefix=z.namelist()[0].split('/')[0]+'/'
        manifest=[]
        def read(rel):
            b=z.read(prefix+rel)
            manifest.append({'member':rel,'bytes':len(b),'sha256':sha(b)})
            return b
        p='ports/minish-cap/project/'
        timings={}
        for label,folder,name in [
          ('P11.3','20260830-173723_P11_3_DEPLOY_HOST_PROVEN_BINARY_PHASE_CAPTURE_R1_1','P11_3_TRACE.tsv'),
          ('P11.4','20260830-210141_P11_4_SINGLE_PRESENT_119HZ_AB_R1_1','P11_4_TRACE.tsv')]:
            rows=[r.split('\t') for r in read(p+'reports/'+folder+'/'+name).decode().splitlines()]
            ticks=[r for r in rows if r[0]=='X']
            late=[int(r[5])/1e6 for r in ticks]
            presents=[int(r[4]) for r in ticks]
            phases={}
            for r in rows:
                if r[0]=='Q': phases.setdefault(r[1],{})[r[3]]=int(r[4])
            present=[(d['PRESENT_END']-d['PRESENT_BEGIN'])/1e6 for d in phases.values()
                     if 'PRESENT_END' in d and 'PRESENT_BEGIN' in d]
            timings[label]={'tick_lateness_ms':stats(late),'present_call_ms':stats(present),
              'one_present_count':presents.count(1),'zero_present_count':presents.count(0),
              'two_present_count':presents.count(2),'mean_presents_per_tick':sum(presents)/len(presents),
              'one_present_ratio':presents.count(1)/len(presents),'two_present_ratio':presents.count(2)/len(presents)}
            with (out/(label.replace('.','_')+'_ticks.csv')).open('w',newline='') as f:
                w=csv.writer(f);w.writerow(['tick','presents','tick_lateness_ns'])
                w.writerows((r[1],r[4],r[5]) for r in ticks)
        summaries={
            'timing_summary.json':'reports/20260830-210141_P11_4_SINGLE_PRESENT_119HZ_AB_R1_1/AB_SUMMARY.json',
            'audio_summary.json':'reports/20260830-225600_P11_5_AUDIO_BUFFER_1600_AB_R1/AUDIO_AB_SUMMARY.json',
            'final_machine_summary.json':'reports/20260905-123332_P13_1_RC1_FINAL_MANUAL_AV_QA_R1/MACHINE_SUMMARY.json',
            'final_acceptance.json':'autolab/P13_1/P13_1_RC1_FINAL_AV_QA_ACCEPTED.json',
            'runtime_winner.json':'autolab/P13_1/P13_1_WINNER.json',
            'stage_a_winner.json':'autolab/P13/P13_AUTOLAB2_STAGE_A_WINNER.json'}
        data={}
        for fn,rel in summaries.items():
            b=read(p+rel);data[fn]=json.loads(b);(out/fn).write_bytes(b)
        for label,key in [('P11.3','baseline_p11_3'),('P11.4','candidate_p11_4')]:
            old=data['timing_summary.json'][key];new=timings[label]
            assert old['ticks']==new['tick_lateness_ms']['n']
            assert abs(old['late_ms']['p95']-new['tick_lateness_ms']['p95'])<1e-9
            assert abs(old['present_call_ms']['p50']-new['present_call_ms']['median'])<1e-9
        mon=read(p+'reports/20260905-123332_P13_1_RC1_FINAL_MANUAL_AV_QA_R1/EXTERNAL_MONITOR.txt').decode().splitlines()
        samples=[x.split('|') for x in mon if x.startswith('S|')]
        assert len(samples)==874
        assert max(float(r[11]) for r in samples)==52.6
        assert all(r[2]=='119.455' and r[3]=='936000' and r[7]=='420000000' for r in samples)
        with (out/'final_monitor_samples.csv').open('w',newline='') as f:
            w=csv.writer(f);w.writerow(['sample','reported_hz','cpu_cap_khz','cpu_min_khz','cpu_governor','cpu_cur_khz','gpu_cap_hz','gpu_min_hz','gpu_governor','gpu_cur_hz','temperature_c','rss_kb'])
            w.writerows(r[1:] for r in samples)
        excerpt={}
        for label,rel,needle in [
            ('quit_before','reports/20260827-184742_P10_3_1D2_EXIT_PROOF_R1/D2_LOG_FULL.txt','[rg34xx] MENU+L2'),
            ('quit_after','reports/20260828-005939_P10_3_1D3_AUTOPILOT_DEPLOY_TEST_PROOF_R1/D3_LOG_FULL.txt','[rg34xx] MENU+L2'),
            ('final_session','reports/20260905-123332_P13_1_RC1_FINAL_MANUAL_AV_QA_R1/SESSION_LOG.txt','')]:
            lines=read(p+rel).decode(errors='strict').splitlines()
            if label=='final_session':
                needles=['Console-Parity','SDL video driver','OpenMP scanline threads','PPU: SDL_Renderer','RG34XX_CPU_CAP_APPLIED_KHZ','RG34XX_GPU_CAP_APPLIED_HZ','RG34XX_SETTINGS','RG34XX_OS_EXIT','RG34XX_REFRESH_ACTIVE_HZ','RG34XX_AUDIO_BUFFER_FRAMES','RG34XX_PROFILE=','Game exited','GAME_EXIT','RG34XX_CPU_MAX_RESTORE','RG34XX_GPU_MAX_RESTORE','PPU shutdown']
                selected=[{'line':i+1,'text':t} for i,t in enumerate(lines) if any(s in t for s in needles)]
            else:
                first=next(i for i,t in enumerate(lines) if needle in t)
                selected=[{'line':i+1,'text':t} for i,t in enumerate(lines[first:],first) if t.startswith(('[rg34xx]','[exitdiag]'))]
            excerpt[label]={'source_member':p+rel,'selection':'Exact lines, original line numbers; omitted unrelated log lines','lines':selected}
        (out/'log_excerpts.json').write_text(json.dumps(excerpt,indent=2,ensure_ascii=False)+'\n')
        result={'schema':'MC_APA_REANALYSIS_1','status':'PASS','new_hardware_runs':0,
          'archive_filename':archive.name,'archive_sha256':sha(archive.read_bytes()),'archive_entries':len(z.infolist()),
          'method':'All X records; linear quantiles at (n-1)*q. PRESENT_END - PRESENT_BEGIN paired by presentation sequence. No trimming.',
          'timing':timings,'final_monitor':{'samples':len(samples),'temperature_max_c':52.6,'high_refresh_ratio':1.0,'cpu_cap_ratio':1.0,'gpu_cap_ratio':1.0},
          'limits':['One historical capture per timing variant; ticks are repeated observations, not independent experiments.',
            'No randomised or matched-scene causal experiment established for P11.3 versus P11.4.',
            'No motion-to-photon latency measurement. No energy saving inferred.',
            'Archive summaries are reproduced, not a new independent hardware replication.'],
          'original_gameplay_bug_corrections':'Not established by the reviewed patches and selected primary records.',
          'sources':manifest}
        (out/'reanalysis.json').write_text(json.dumps(result,indent=2,ensure_ascii=False)+'\n')
        print(json.dumps({'status':'PASS','timing':timings,'sources':len(manifest)},indent=2))
if __name__=='__main__':run(Path(sys.argv[1]),Path(sys.argv[2]))
