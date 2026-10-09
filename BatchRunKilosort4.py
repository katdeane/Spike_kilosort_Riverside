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
     🗸 loop through subject folders if necessary  
         🗸 wrap the current forloop in a larger one to loop through subject folders
         🗸 create a condition to skip broader loop and just perform the kilosort loop once
         
     - We need to either force output for small cluster sizes or get the loop to skip those.
       This is tricky though because it might mean messing with kilosort code
       Or maybe we can use "try" and "exception" inside of the forloop - if kilosort
       breaks, the exception will be just to continue to the next iteration of the loop. 
       I generally hate the "try" function but if we avoid messing with the kilo 
       code, that's probably better
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

# if the user would like to select the data folder with _kilo folders to run through all data
FolderList = [f for f in listdir(path) if isdir(join(path, f))]
FolderList = [f for f in FolderList if f.endswith('_kilo')]

if not FolderList: 
    # not starting from grand folder so no _kilo folders, go as usual
    
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
                settings=settings, probe_name='C:\\kilosort\\probe.json',
                save_preprocessed_copy=True
                )
else:
    # _kilo folders detected, run through all of them
    for idir in FolderList:
        # specify path to this folder
        deeppath = os.path.join(path, idir)
        
        # pull list of bin files and the list of directories
        FileList = [f for f in listdir(deeppath) if isfile(join(deeppath, f))]
        FileList = [f for f in FileList if f.endswith('.bin')]
        DirList  = [f for f in listdir(deeppath) if isdir(join(deeppath, f))]
        # remove files for which there is already a directory (already sorted)
        FileList =  [f for f in FileList if not f.startswith(tuple(DirList))]

        # now loop through files to process
        for ibin in FileList:
            filepath = deeppath + '\\' + ibin
            resultpath = deeppath + '\\' + ibin[0:-9] # cutting off '_bulk.bin'
        
            settings = {'filename': filepath, 'n_chan_bin': 32, 'results_dir': resultpath}
        
            ops, st, clu, tF, Wall, similar_templates, is_ref, est_contam_rate, kept_spikes = \
                run_kilosort(
                    settings=settings, probe_name='C:\\kilosort\\probe.json',
                    save_preprocessed_copy=True
                    )
    
    
    

    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    