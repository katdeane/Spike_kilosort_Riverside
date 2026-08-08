# -*- coding: utf-8 -*-
"""
Created on Sat May 16 15:40:00 2026

 
 TO DO: 
     - Figure out best settings for single neuron spike detection 
     🗸 create loop to run through .bin files in output folder 
         🗸 print file directory in folder
         🗸 concatonate into list
         🗸 loop
     🗸 override default to generate folder with unique names for Phy sorting
     - loop through subject folders if necessary  
         - ask user if folder holds one subject's data or a subset of subject folders
         - for the latter, wrap the current forloop in a larger one to loop through subject folders
         - for the latter create a condition to skip broader loop and just perform the kilosort loop once
"""

import os
from os import listdir
from os.path import isfile, join, isdir
from kilosort import run_kilosort
from PyQt5.QtWidgets import QApplication, QFileDialog 
import sys

# set the operating directory 
if os.path.isdir("E:\\Spike_kilosort_Riverside"):
    homedir="E:\\Spike_kilosort_Riverside\\Data"
elif os.path.isdir("C:\\Users\\jimen\\Documents\\Spike_kilosort_Riverside"):
    homedir="C:\\Users\\jimen\\Documents\\Spike_kilosort_Riverside\\Data"
else: print('add your working directory to the list')


#also Jimena's alternative selecting folder function
app = QApplication(sys.argv)
path = QFileDialog.getExistingDirectory(
    None,
    "Select folder with bin data",
    homedir,
)

# sanity check:
#print(path)


# pull list of bin files and the list of directories
FileList = [f for f in listdir(path) if isfile(join(path, f))]
FileList = [f for f in FileList if f.endswith('.bin')]
DirList  = [f for f in listdir(path) if isdir(join(path, f))]
# remove files for which there is already a directory (already sorted)
FileList =  [f for f in FileList if not f.startswith(tuple(DirList))]

# now loop through files to process
for ibin in FileList:
    filepath = path + '\\' + ibin
    resultpath = path + '\\' + ibin[0:-9] # cutting off '_bulk.bin'

    settings = {'filename': filepath, 'n_chan_bin': 32, 'results_dir': resultpath}

    ops, st, clu, tF, Wall, similar_templates, is_ref, est_contam_rate, kept_spikes = \
        run_kilosort(
            settings=settings, probe_name='C:\\kilosort\\probe.json'
            # save_preprocessed_copy=True
            )
    