# -*- coding: utf-8 -*-
"""
Created on Sat May 16 15:40:00 2026

 
 TO DO: 
     - Figure out best settings for single neuron spike detection 
     - create loop to run through .bin files in output folder 
         - print file directory in folder
         - concatonate into list
         - loop
     - override default to generate folder with unique names for Phy sorting
"""

import os
from kilosort import run_kilosort

homedir=os.path.dirname("E:\Spike_kilosort_Riverside")

filepath = "E:\\Spike_kilosort_Riverside\\Data\\240213_VMP06_kilo\\allego_4__uid0213-12-30-28_bulk.bin"
resultpath = filepath + "\\newname"

settings = {'filename': filepath, 'n_chan_bin': 32, 'results_dir': resultpath}

ops, st, clu, tF, Wall, similar_templates, is_ref, est_contam_rate, kept_spikes = \
    run_kilosort(
        settings=settings, probe_name='probe.json',
        # save_preprocessed_copy=True
        )
    
    
    
    