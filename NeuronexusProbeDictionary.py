# -*- coding: utf-8 -*-
"""
Created on Fri Aug  7 16:22:39 2026

Recreated probe mapping dictionary, hopefully it works!

"""


import numpy as np
from kilosort.io import save_probe
import matplotlib.pyplot as plt

# creating physical array
arr1 = np.array([17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32])
arr2 = np.array([16,15,14,13,12,11,10,9,8,7,6,5,4,3,2,1])
interleaved_arr = np.stack((arr1, arr2), axis=-1).ravel() 

# map channel positions, subtract 1 to match indexing
chanMap = interleaved_arr -1

# structure channel coordinates 
n_chan = 32
# single shank, all x-coordinates = 0 
xc = np.zeros(n_chan) 
# descending from 1550µm down to 0µm - this is what it looks like on the neuronexus page?
# kd: it is true and then 0µm should start at the top, meaning 17 = 0
yc = (np.arange(n_chan)[::-1] * 50) - 1550
kcoords = np.zeros(n_chan)


#mapping dictionary 
probe = {
    'chanMap': chanMap,
    'xc': xc,
    'yc': yc,
    'kcoords': kcoords,
    'n_chan': n_chan
}

#sanity check plot 
print("Channel Map:")
for y, ch in zip(yc, chanMap + 1):
    print(f"Position Y = {y:4d} µm -> Channel {ch}")

# save probe in kilosort folder
save_probe(probe, 'C:\\kilosort\\probe.json') 


# if you want a prettier plot
plt.figure(figsize=(4, 10))

# plot physical channel sites
plt.scatter(xc, yc, c="dodgerblue", s=250, edgecolors="black", zorder=2)

# label channels (adding 1 to account for indexing)
for i in range(n_chan):  
    channel_display_label = chanMap[i] + 1
    plt.text(
        xc[i],
        yc[i],
        str(channel_display_label),
        fontsize=9,
        fontweight="bold",
        ha="center",
        va="center",
        color="white",
        zorder=3,
    )

# make it look nice
plt.title("Probe Map", fontsize=11, fontweight="bold", pad=15)
plt.xlabel("X Coordinate (µm)")
plt.ylabel("Y Coordinate (µm)")
plt.xlim(-50, 50)  # Center the linear shank visually
#plt.ylim(0, max(yc) + 100)  # Start axis at 0µm to show distance from tip
plt.grid(True, linestyle="--", alpha=0.5, zorder=1)

plt.tight_layout()
plt.show()


