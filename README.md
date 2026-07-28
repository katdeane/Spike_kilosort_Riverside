# Spike sorting information

Raw data is stored from allego within subject folders (*yymmdd_SID##*). When adding a subject to your \Data folder, create a folder of the same name for kilosort output (*yymmddSID##_kilo*). 

**TO DO: figure out how to automatically implement the file-naming**

## Step 1:Curate

Raw files from Allego need to be converted to Kilosort files through Curate with the following steps:

- Open Curate.

- Drag the following boxes into the workspace and connect them:
  - (batch)source: allego\*\*\*\_data.xdat
  - bandpass filter: 300 - 3000 Hz (2nd order)
  - (batch)sink: allego\*\*\*.kilosort2.json

- Run Protocol

You should put this output into the *yymmddSID##_kilo* folder

## Step 2: KiloSort

- Open Anaconda Navigator
- Navigate to Environments tab and select 'kilosort' (assuming you've installed it, go to their documentation pages to do so)
- Navigate to Home tab, launch Spyder
- Open <code>BatchRunKilosort4.py</code>

Kilosort currently needs 3 things:
1. .bin data
   - curate output in *yymmddSID##_kilo* folder
2. Probe layout
   - A1x32-6mm-50-177 (see mapping below)
3. Parameters
   - currently default settings

**The to do list is in the .py script**

### To generate probe mapping:
Open python terminal in 'kilosort' environment (type <code>ipython</code> in anaconda_prompt)  
<code>from kilosort.io import save\_probe
 import numpy as np
 arr1 = np.array(\[17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32])
 arr2 = np.array(\[16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1])
 interleaved\_arr = np.stack((arr1, arr2), axis =-1).ravel()
 print(interleaved\_arr)
 chanMap = np.arange(32)
 kcoords = np.zeros(32)
 xc = np.ones(32)
 yc = np.array(interleaved\_arr)\*50
 n\_chan=32
 probe = {
     'chanMap': chanMap,
     'xc': xc,
     'yc': yc,
     'kcoords': kcoords,
    'n\_chan': n\_chan
  }
 print(probe)
 save\_probe(probe, 'C:/kilosort/probe.json')</code>

## Step 3: Phy
[Phy Documentation](https://phy.readthedocs.io/en/latest/)

- Open anaconda_prompt in 'kilosort' environment
- type <code>phy template-gui E:/Spike_kilosort_Riverside/Data/*yymmdd_SID##_kilo*/kilosort4/params.py</code> (kilosort folder name will hopefully become unique also)
- Perform The Sort<sup>tm</sup>

### Manual sorting rules:
[Video on Phy](https://www.youtube.com/watch?v=czdwIr-v5Yc)
According to Nick Steinmetz:
- clean refractory period
- large amplitude
- dissimilar waveform to anything else nearby
- consistent waveform
- spikes not lost below threshold

## Step 5: Matlab
Data needed for Matlab:
- spike timing (x)
- spike location (y)
- spike IDs
- spike waveforms

Generate parallel pipeline to CSD_Riverside, slap on identifying file names, stack trials, get graphics, do stats (probably in R).



