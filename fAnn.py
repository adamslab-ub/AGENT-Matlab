import os
import scipy as sp
from scipy.io import loadmat
from scipy.io import savemat
import numpy as np
import matplotlib.pyplot as plt
import random
import math
import multiprocessing as mp
import statistics
import copy

import func_ANN

def fAnn_f(inp,out_needed):


    inp = copy.deepcopy(np.append(inp,1))

    min_output =out_needed['min_output_local']
    max_output = out_needed['max_output_local']
    min_inp = out_needed['min_inp_local']
    max_inp = out_needed['max_inp_local']
    max_max_inp = max(max_inp)
    min_min_inp = max(min_inp)


    n_l = out_needed['n_l_local']#num layer
    l = out_needed['l_local']#layers

    w = out_needed['w_local'] # Adjacency Matrix
    e = out_needed['e_local'] # Enable Matrix

    list_node = out_needed['list_node']

    num_input = out_needed['num_input_local']
    num_output = out_needed['num_output_local']

    size_layer = np.zeros(shape=[n_l+1,1])
    size_layer[1] = len(l[1]) #be aware of this ## -1 for making it right size after adding 0

    # #print('xxxxxxxxxxxx')
    # #print(size_layer[1])
    # ssads
    for j in range(1,int(num_input-1+1)):
        inp[j] = 2 * (inp[j]-min_inp[j]) / (max_inp[j]-min_inp[j]) - 0.5

    # inp = copy.deepcopy(2*(inp-0.5))
    # #print(inp)
    # dsad
    F_t = np.zeros(shape=[num_output+1,1])

    v = dict()
    v[1] = copy.deepcopy(inp)
    f = copy.deepcopy(v)

    # #print(size_layer[1])

    for j in range(1,int(size_layer[1]+1)):


        for i_t in range (1,int(list_node[l[1][j]]['list_node_time']+1)):

            # print(list_node[l[1][j]]['list_node_history'])
            v[1][j] = copy.deepcopy(v[1][j] + list_node[l[1][j]]['list_node_history_W'][i_t] * list_node[l[1][j]]['list_node_history'][i_t])

        for i_t in range (int(list_node[l[1][j]]['list_node_time']),2-1,-1):# not sure about limits of for loop
            list_node[l[1][j]]['list_node_history'][i_t] = copy.deepcopy(list_node[l[1][j]]['list_node_history'][i_t-1])
            if list_node[l[1][j]]['list_node_history'][i_t] > max_max_inp:
                list_node[l[1][j]]['list_node_history'][i_t] = max_max_inp
            if list_node[l[1][j]]['list_node_history'][i_t] < min_min_inp:
                list_node[l[1][j]]['list_node_history'][i_t] = min_min_inp

        if list_node[l[1][j]]['list_node_time']>=1:
            list_node[l[1][j]]['list_node_history'][1] = copy.deepcopy(v[1][j])
            list_node[l[1][j]]['list_node_history'][1] = copy.deepcopy(v[1][j])
            if list_node[l[1][j]]['list_node_history'][1]> max_max_inp:
                list_node[l[1][j]]['list_node_history'][1] = max_max_inp
            if list_node[l[1][j]]['list_node_history'][1]< min_min_inp:
                list_node[l[1][j]]['list_node_history'][1] = min_min_inp

        f [1][j] = copy.deepcopy(v[1][j])


    for i_l1 in range(2,n_l-1+1):

        # size_layer[i_l1] = copy.deepcopy(np.size(l[i_l1])-1)
        size_layer[i_l1] = copy.deepcopy(len(l[i_l1]))

        v[i_l1] = dict()
        f[i_l1] = dict()

        for i_l2 in range(1,i_l1-1+1):
            for j1 in range(1,int(size_layer[i_l1]+1)):
                v[i_l1][j1]=0
                for j2 in range(1,int(size_layer[i_l2]+1)):
                    v[i_l1][j1] = copy.deepcopy(v[i_l1][j1]+e[l[i_l2][j2],l[i_l1][j1]]*w[l[i_l2][j2],l[i_l1][j1]]*f[i_l2][j2])

                for i_t in range(1,list_node[l[i_l1][j1]]['list_node_time']+1):
                    v[i_l1][j1] = copy.deepcopy(v[i_l1][j1] + list_node[l[i_l1][j1]]['list_node_history_W'][i_t] * list_node[l[i_l1][j1]]['list_node_history'][i_t])

                for i_t in range(list_node[l[i_l1][j1]]['list_node_time'],2-1,-1):
                    list_node[l[i_l1][j1]]['list_node_history'][i_t] = copy.deepcopy(list_node[l[i_l1][j1]]['list_node_history'][i_t-1])
                    if list_node[l[i_l1][j1]]['list_node_history'][i_t]> max_max_inp:
                        list_node[l[i_l1][j1]]['list_node_history'][i_t] = max_max_inp
                    if list_node[l[i_l1][j1]]['list_node_history'][i_t]< min_min_inp:
                        list_node[l[i_l1][j1]]['list_node_history'][i_t] = min_min_inp

                if list_node[l[i_l1][j1]]['list_node_time']>=1:
                    list_node[l[i_l1][j1]]['list_node_history'][1] = copy.deepcopy(v[i_l1][j1])
                    if list_node[l[i_l1][j1]]['list_node_history'][1]> max_max_inp:
                        list_node[l[i_l1][j1]]['list_node_history'][1] = max_max_inp
                    if list_node[l[i_l1][j1]]['list_node_history'][1]< min_min_inp:
                        list_node[l[i_l1][j1]]['list_node_history'][1] = min_min_inp
                f[i_l1][j1] = copy.deepcopy(func_ANN.func_ANN_f(v[i_l1][j1],list_node[l[i_l1][j1]]['list_node_type']))


                if ((l[i_l1][j1]>num_input) and (l[i_l1][j1]<=num_input+num_output)):
                    F_t[l[i_l1][j1]-num_input] = copy.deepcopy(f[i_l1][j1])

                f[i_l1][j1] = copy.deepcopy(func_ANN.func_ANN_f(v[i_l1][j1],list_node[l[i_l1][j1]]['list_node_type']))


    # LAST LAYER fORCED TO BE LINEAR
    i_l1 = copy.deepcopy(n_l)
    v[n_l] = dict()
    f[n_l] = dict()
    # size_layer[i_l1] = copy.deepcopy(np.size(l[n_l])-1)
    size_layer[i_l1] = copy.deepcopy(len(l[i_l1]))

    for i_l2 in range(1,i_l1-1+1):
        for j1 in range (1,int(size_layer[i_l1]+1)):
            v[i_l1][j1] = 0
            for j2 in range(1,int(size_layer[i_l2]+1)):
                v[i_l1][j1] = copy.deepcopy(v[i_l1][j1]+e[l[i_l2][j2],l[i_l1][j1]]*w[l[i_l2][j2],l[i_l1][j1]]*f[i_l2][j2])

            for i_t in range (1,int(list_node[l[i_l1][j1]]['list_node_time']+1)):
                v[i_l1][j1] = copy.deepcopy(v[i_l1][j1] + list_node[l[i_l1][j1]]['list_node_history_W'][i_t] * list_node[l[i_l1][j1]]['list_node_history'][i_t])

            for i_t in range( int(list_node[l[i_l1][j1]]['list_node_time']),2-1,-1):
                list_node[l[i_l1][j1]]['list_node_history'][i_t] = copy.deepcopy(list_node[l[i_l1][j1]]['list_node_history'][i_t-1])
                if list_node[l[i_l1][j1]]['list_node_history'][i_t]> max_max_inp:
                    list_node[l[i_l1][j1]]['list_node_history'][i_t] = max_max_inp
                if list_node[l[i_l1][j1]]['list_node_history'][i_t]< min_min_inp:
                    list_node[l[i_l1][j1]]['list_node_history'][i_t] = min_min_inp

            if list_node[l[i_l1][j1]]['list_node_time']>=1:
                list_node[l[i_l1][j1]]['list_node_history'][1] = copy.deepcopy(v[i_l1][j1])
                if list_node[l[i_l1][j1]]['list_node_history'][1] > max_max_inp:
                    list_node[l[i_l1][j1]]['list_node_history'][1] = max_max_inp
                if list_node[l[i_l1][j1]]['list_node_history'][1] < min_min_inp:
                    list_node[l[i_l1][j1]]['list_node_history'][1] = min_min_inp

            f[i_l1][j1] = copy.deepcopy(func_ANN.func_ANN_f(v[i_l1][j1],0))

            if ((l[i_l1][j1]>num_input) and (l[i_l1][j1]<=num_input+num_output)):
                F_t[l[i_l1][j1]-num_input] = copy.deepcopy(f[i_l1][j1])

    for i in range(1,num_output+1):
        if F_t[i]>max_output[i]:
            F_t[i] = copy.deepcopy(max_output[i])
        if F_t[i]<min_output[i]:
            F_t[i] = copy.deepcopy(min_output[i])

    out_needed['list_node'] = copy.deepcopy(list_node)
    outp = copy.deepcopy(np.transpose(F_t))


    return [outp,out_needed]
