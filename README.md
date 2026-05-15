# Spike sorting information



## Step 1:Curate

Raw files from Allego need to be converted to Kilosort files through Curate with the following steps:

* source: allego\*\*\*\_data.xdat
* bandpass filter: 300 - 3000 Hz (2nd order)
* sink: allego\*\*\*.kilosort2.json



## Step 2: KiloSort

* Load .bin data 
* Probe Layout: 

> Open python terminal under KILOSORT environment in anaconda 

>

> from kilosort.io import save\_probe

> import numpy as np

> arr1 = np.array(\[17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32])

> arr2 = np.array(\[16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1])

> interleaved\_arr = np.stack((arr1, arr2), axis =-1).ravel()

> print(interleaved\_arr)

> chanMap = np.arange(32)

> kcoords = np.zeros(32)

> xc = np.ones(32)

> yc = np.array(interleaved\_arr)\*50

> n\_chan=32

> probe = {

>     'chanMap': chanMap,

>     'xc': xc,

>   'yc': yc,

>     'kcoords': kcoords,

>    'n\_chan': n\_chan

>  }

> print(probe)

>

> save\_probe(probe, 'C:/kilosort/probe.json')

* Parameters: 
* Save out with a unique folder name for the subject



## Step 3

Delete raw files, they are taking up *way* too much space



## Step 4

Open Phy on Kilosort4 output files

