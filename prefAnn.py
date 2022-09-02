import os
import scipy as sp
from scipy.io import loadmat
from scipy.io import savemat
import numpy as np
import matplotlib.pyplot as plt
import random
import math
import multiprocessing as mp

def prefAnn_f(global_var_big):

    # global min_output max_output min_inp max_inp;
    # global num_input num_output;

    min_output = global_var_big['min_output']
    max_output = global_var_big['max_output']
    min_inp = global_var_big['min_inp']
    max_inp = global_var_big['max_inp']
    num_input = global_var_big['num_input']
    num_output = global_var_big['num_output']

    out_needed = dict()
    out_needed['min_output_local']=min_output
    out_needed['max_output_local']=max_output
    out_needed['min_inp_local']=min_inp
    out_needed['max_inp_local']=max_inp

    out_needed['num_input_local']=num_input
    out_needed['num_output_local']=num_output

    return out_needed
