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

def func_ANN_f(v,type_f):

    #print(v)
    if type_f==1:
        if v<-20: # for pythonn numerical issues
            f = 0
        else:
            f = 1/(1+math.exp(-4.9*v))
    elif type_f==2:
        f = max(min(v+.5,1),0)
    elif type_f==3:
        if v<-100: # for pythonn numerical issues
            f = 0
        else:
            f=1/(1+math.exp(-1*v))
    elif type_f==4:
        f = math.tanh(v)
    elif type_f==0: # ONLY FOR THE LAST LAYER
        f = v
    #print('XXXXXXXXXXXXXXX')
    #print(f)

    return f
