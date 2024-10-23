#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Jan 11 17:19:25 2021

"""
##############################################################################
#                        PARAMETERS
##############################################################################


# clear all variables
from IPython import get_ipython
get_ipython().magic('reset -sf')
# setting packages
import numpy as np
import pandas as pd
import pickle as pkl
from matplotlib import pyplot as plt
from z_NNMFSparsVafm import NNMF_Call_Vafm



name_input = ["S1_Env0_Elec0.csv ","S1_Env1_Elec0.csv","S1_Env2_Elec0.csv","S1_Env0_Elec1.csv ","S1_Env1_Elec1.csv","S1_Env2_Elec1.csv",
              "S2_Env0_Elec0.csv ","S2_Env1_Elec0.csv","S2_Env2_Elec0.csv","S2_Env0_Elec1.csv ","S2_Env1_Elec1.csv","S2_Env2_Elec1.csv",
              "S3_Env0_Elec0.csv ","S3_Env1_Elec0.csv","S3_Env2_Elec0.csv","S3_Env0_Elec1.csv ","S3_Env1_Elec1.csv","S3_Env2_Elec1.csv",
              "S4_Env0_Elec0.csv ","S4_Env1_Elec0.csv","S4_Env2_Elec0.csv","S4_Env0_Elec1.csv ","S4_Env1_Elec1.csv","S4_Env2_Elec1.csv",
              "S5_Env0_Elec0.csv ","S5_Env1_Elec0.csv","S5_Env2_Elec0.csv","S5_Env0_Elec1.csv ","S5_Env1_Elec1.csv","S5_Env2_Elec1.csv",
              "S6_Env0_Elec0.csv ","S6_Env1_Elec0.csv","S6_Env2_Elec0.csv","S6_Env0_Elec1.csv ","S6_Env1_Elec1.csv","S6_Env2_Elec1.csv",
              "S7_Env0_Elec0.csv ","S7_Env1_Elec0.csv","S7_Env2_Elec0.csv","S7_Env0_Elec1.csv ","S7_Env1_Elec1.csv","S7_Env2_Elec1.csv",
              "S8_Env0_Elec0.csv ","S8_Env1_Elec0.csv","S8_Env2_Elec0.csv","S8_Env0_Elec1.csv ","S8_Env1_Elec1.csv","S8_Env2_Elec1.csv",
              "S9_Env0_Elec0.csv ","S9_Env1_Elec0.csv","S9_Env2_Elec0.csv","S9_Env0_Elec1.csv ","S9_Env1_Elec1.csv","S9_Env2_Elec1.csv"]

for ni in name_input:

    test = pd.read_csv("./data_in/"+ni,header=None)
    # test = np.transpose(test)
    
    # run synergies
    results = NNMF_Call_Vafm(test,8,1000)
    


name_output = ["S1_Env0_Elec0.pkl ","S1_Env1_Elec0.pkl","S1_Env2_Elec0.pkl","S1_Env0_Elec1.pkl ","S1_Env1_Elec1.pkl","S1_Env2_Elec1.pkl",
              "S2_Env0_Elec0.pkl ","S2_Env1_Elec0.pkl","S2_Env2_Elec0.pkl","S2_Env0_Elec1.pkl ","S2_Env1_Elec1.pkl","S2_Env2_Elec1.pkl",
              "S3_Env0_Elec0.pkl ","S3_Env1_Elec0.pkl","S3_Env2_Elec0.pkl","S3_Env0_Elec1.pkl ","S3_Env1_Elec1.pkl","S3_Env2_Elec1.pkl",
              "S4_Env0_Elec0.pkl ","S4_Env1_Elec0.pkl","S4_Env2_Elec0.pkl","S4_Env0_Elec1.pkl ","S4_Env1_Elec1.pkl","S4_Env2_Elec1.pkl",
              "S5_Env0_Elec0.pkl ","S5_Env1_Elec0.pkl","S5_Env2_Elec0.pkl","S5_Env0_Elec1.pkl ","S5_Env1_Elec1.pkl","S5_Env2_Elec1.pkl",
              "S6_Env0_Elec0.pkl ","S6_Env1_Elec0.pkl","S6_Env2_Elec0.pkl","S6_Env0_Elec1.pkl ","S6_Env1_Elec1.pkl","S6_Env2_Elec1.pkl",
              "S7_Env0_Elec0.pkl ","S7_Env1_Elec0.pkl","S7_Env2_Elec0.pkl","S7_Env0_Elec1.pkl ","S7_Env1_Elec1.pkl","S7_Env2_Elec1.pkl",
              "S8_Env0_Elec0.pkl ","S8_Env1_Elec0.pkl","S8_Env2_Elec0.pkl","S8_Env0_Elec1.pkl ","S8_Env1_Elec1.pkl","S8_Env2_Elec1.pkl",
              "S9_Env0_Elec0.pkl ","S9_Env1_Elec0.pkl","S9_Env2_Elec0.pkl","S9_Env0_Elec1.pkl ","S9_Env1_Elec1.pkl","S9_Env2_Elec1.pkl"]
        
    


# path data out
savePath = "./data_out/"
    
# for no in name_output:
    
    
    # Save results
    # with open(savePath+no,"wb") as handle:
    #     pkl.dump(results,handle,protocol=pkl.HIGHEST_PROTOCOL)
    
    
no = name_output[0]   

# Read pickle
with open(savePath+no,"rb") as handle:
    results = pkl.load(handle)
        
        
    import numpy
    
    numpy.savetxt("./data_plot_matlab/"+no[0:13]+"_primitives.csv", results[2]["Primitives"], delimiter=",")
    numpy.savetxt("./data_plot_matlab/"+no[0:13]+"_modules.csv", results[2]["Modules"], delimiter=",")
    
    
    import spm1d
    
    # figure
    name_muscles = ["ta","abd","tric","da","sol","es","bic","dp"] 
    nsyn=2   # = -1
    cycleSize = 2000
    
    nb_mouv1 = 5
    nb_mouv = round(np.shape(results[0]["Data"])[0]/cycleSize)
    x_bar = np.arange(8)
    fig, ax = plt.subplots(2,nsyn+1,figsize=(20,14))
    fig.suptitle(no+" / Vaf="+str(round(results[nsyn]['Vaf'],2)))
    for s,syn in enumerate(results[nsyn]["Modules"]):
        data2plot = np.reshape(results[nsyn]["Primitives"].iloc[s].values,(nb_mouv,cycleSize))
        
        # mean+sd trace
        # spm1d.plot.plot_mean_sd(data2plot,ax=ax[0,s])
        
        # all trace + mean
        for c in range(nb_mouv):
            ax[0,s].plot(data2plot[c])
            mean2plot = np.mean(data2plot,axis=0)
            ax[0,s].plot(mean2plot,color='black')
                    
        ax[1,s].bar(x_bar,results[nsyn]["Modules"][s].T,width=0.5)
        ax[1,s].set_xticks([0,1,2,3,4,5,6,7])
        
        ax[1,s].set_xticklabels(name_muscles)
        
    fig.savefig("./graph/testexport.eps", format='eps')
    fig.savefig("./graph/"+no[0:13]+".png", format='png')

    
    # export data 2 plot in csv file
    

