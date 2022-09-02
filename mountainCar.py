import math
import gym
from gym import spaces
from gym.utils import seeding
import numpy as np
import scipy.io as sio
import random
import time
import copy

from gym import wrappers

import prefAnn
import fAnn

#import myMonitor as MM
class Continuous_MountainCarEnv(gym.Env):
    metadata = {
        'render.modes': ['human', 'rgb_array'],
        'video.frames_per_second': 30
    }

    def __init__(self):
        self.min_action = -1.0
        self.max_action = 1.0
        self.min_position = -1.2
        self.max_position = 0.6
        self.max_speed = 0.07
        self.goal_position = 0.45#0.45 # was 0.5 in gym, 0.45 in Arnaud de Broissia's version
        self.power = 0.0015#0.0015

        self.low_state = np.array([self.min_position, -self.max_speed])
        self.high_state = np.array([self.max_position, self.max_speed])

        self.viewer = None

        self.action_space = spaces.Box(low=self.min_action, high=self.max_action, shape=(1,))
        self.observation_space = spaces.Box(low=self.low_state, high=self.high_state)

        self.seed()
        self.reset()

    def seed(self, seed=None):
        self.np_random, seed = seeding.np_random(seed)
        return [seed]

    def step(self, action):
        position = self.state[0]
        velocity = self.state[1]
        force = min(max(action, -1.0), 1.0)
        velocity += force*self.power -0.0025 * math.cos(3*position)
        if (velocity > self.max_speed): 
            velocity = self.max_speed
        if (velocity < -self.max_speed): 
            velocity = -self.max_speed        
        position += velocity
        if (position > self.max_position): 
            position = self.max_position
        if (position < self.min_position): 
            position = self.min_position
        if (position==self.min_position and velocity<0): 
            velocity = 0
        done = bool(position >= self.goal_position)
        reward = 0
        if done:
            reward = 100.0
        reward-= math.pow(action,2)*0.1
        
        self.state = np.array([position, velocity])
        return self.state, reward, done,{}
        
    def myStep(self,action,state):
        position = state[0]
        velocity = state[1]
        force = min(max(action, -1.0), 1.0)
        velocity += force*0.0015 -0.0025 * math.cos(3*position)
        if (velocity > 0.07): 
            velocity = 0.07
        if (velocity < -0.07): 
            velocity = -0.07
        position += velocity
        if (position > 0.6): 
            position = 0.6
        if (position < -1.2): 
            position = -1.2
        if (position==-1.2 and velocity<0): 
            velocity = 0
        done = bool(position >= 0.45)
        reward = 0
        if done:
            reward = 100.0
        reward-= math.pow(action,2)*0.1
        state = np.array([position, velocity])
        return state, reward, done, {}
    
    def reset(self):
        self.state = np.array([self.np_random.uniform(low=-0.6, high=-0.4), 0])
        return np.array(self.state)

    def _height(self, xs):
        return np.sin(3 * xs)*.45+.55

    def render(self, mode='human'):
        screen_width = 600
        screen_height = 400

        world_width = self.max_position - self.min_position
        scale = screen_width/world_width
        carwidth=40
        carheight=20


        if self.viewer is None:
            from gym.envs.classic_control import rendering
            self.viewer = rendering.Viewer(screen_width, screen_height)
            xs = np.linspace(self.min_position, self.max_position, 100)
            ys = self._height(xs)
            xys = list(zip((xs-self.min_position)*scale, ys*scale))

            self.track = rendering.make_polyline(xys)
            self.track.set_linewidth(4)
            self.viewer.add_geom(self.track)

            clearance = 10

            l,r,t,b = -carwidth/2, carwidth/2, carheight, 0
            car = rendering.FilledPolygon([(l,b), (l,t), (r,t), (r,b)])
            car.add_attr(rendering.Transform(translation=(0, clearance)))
            self.cartrans = rendering.Transform()
            car.add_attr(self.cartrans)
            self.viewer.add_geom(car)
            frontwheel = rendering.make_circle(carheight/2.5)
            frontwheel.set_color(.5, .5, .5)
            frontwheel.add_attr(rendering.Transform(translation=(carwidth/4,clearance)))
            frontwheel.add_attr(self.cartrans)
            self.viewer.add_geom(frontwheel)
            backwheel = rendering.make_circle(carheight/2.5)
            backwheel.add_attr(rendering.Transform(translation=(-carwidth/4,clearance)))
            backwheel.add_attr(self.cartrans)
            backwheel.set_color(.5, .5, .5)
            self.viewer.add_geom(backwheel)
            flagx = (self.goal_position-self.min_position)*scale
            flagy1 = self._height(self.goal_position)*scale
            flagy2 = flagy1 + 50
            flagpole = rendering.Line((flagx, flagy1), (flagx, flagy2))
            self.viewer.add_geom(flagpole)
            flag = rendering.FilledPolygon([(flagx, flagy2), (flagx, flagy2-10), (flagx+25, flagy2-5)])
            flag.set_color(.8,.8,0)
            self.viewer.add_geom(flag)

        pos = self.state[0]
        self.cartrans.set_translation((pos-self.min_position)*scale, self._height(pos)*scale)
        self.cartrans.set_rotation(math.cos(3 * pos))

        return self.viewer.render(return_rgb_array = mode=='rgb_array')

    def close(self):
        if self.viewer: self.viewer.close()
            
            
class NN():
    def func_Ann(self,v,whichType):
        f = 0
        if whichType == 1:
            if v < -81:
                f = 1/(1+math.exp(700))
        elif whichType == 2:
            f = max(min(v+0.5,1),0)
        elif whichType == 3:
            f = 1/(1+math.exp(-v))
        elif whichType == 4:
            f = math.tanh(v)
        return f    
    
    def prefANN(self,outNeeded):
        outNeededKey=outNeeded['out_needed_local']
        outNeededValue = outNeededKey[0,0]
        minOutput = outNeededValue['min_output_local']
        step_for_CUTOFF = outNeededValue['step_for_CUTOFF']
        maxOutput = outNeededValue['max_output_local']
        minInput = outNeededValue['min_inp_local'][0]
        maxInput = outNeededValue['max_inp_local'][0]
        numNodes = outNeededValue['n_n_local'][0][0]
        numLayers = outNeededValue['n_l_local'][0][0] # Gives you the number of layers
        layers = outNeededValue['l_local'][0]
        adMat = outNeededValue['w_local']
        enabMat = outNeededValue['e_local']
        listNodes = outNeededValue['list_node'][0] # [ln_id,ln_type,ln_time,ln_history,ln_history_w]
        numInputs = outNeededValue['num_input_local'][0][0]
        numOutputs = outNeededValue['num_output_local'][0][0]
        return [minOutput,maxOutput,minInput,maxInput,numNodes,numLayers,layers,adMat,enabMat,listNodes,numInputs,numOutputs]
#        print(outNeeded)
#        outNeededKey=outNeeded['SAVE_DATA_LATER']
#        outNeededKey2 = outNeededKey['out_needed_local'] 
#        outNeededValue = outNeededKey2[0,0]
#        minOutput = outNeededValue['min_output_local'][0][0][0]
#        maxOutput = outNeededValue['max_output_local'][0][0][0]
#        minInput = outNeededValue['min_inp_local'][0][0][0]
#        maxInput = outNeededValue['max_inp_local'][0][0][0]
#        numNodes = outNeededValue['n_n_local'][0][0][0][0]
#        numLayers = outNeededValue['n_l_local'][0][0][0][0] # Gives you the number of layers
#        layers = outNeededValue['l_local'][0][0][0]
#        adMat = outNeededValue['w_local'][0][0]
#        enabMat = outNeededValue['e_local'][0][0]
#        listNodes = outNeededValue['list_node'][0][0][0] # [ln_id,ln_type,ln_time,ln_history,ln_history_w]
#        numInputs = outNeededValue['num_input_local'][0][0][0][0]
#        numOutputs = outNeededValue['num_output_local'][0][0][0][0]
#        return [minOutput,maxOutput,minInput,maxInput,numNodes,numLayers,layers,adMat,enabMat,listNodes,numInputs,numOutputs]

#    def prefANN(self,outNeeded):
#        outNeededKey=outNeeded['out_needed_local']
#        outNeededValue = outNeededKey[0,0]
#        minOutput = outNeededValue['min_output_local']
#        step_for_CUTOFF = outNeededValue['step_for_CUTOFF']
#        maxOutput = outNeededValue['max_output_local']
#        minInput = outNeededValue['min_inp_local'][0]
#        maxInput = outNeededValue['max_inp_local'][0]
#        numNodes = outNeededValue['n_n_local'][0][0]
#        numLayers = outNeededValue['n_l_local'][0][0] # Gives you the number of layers
#        layers = outNeededValue['l_local'][0]
#        adMat = outNeededValue['w_local']
#        enabMat = outNeededValue['e_local']
#        listNodes = outNeededValue['list_node'][0] # [ln_id,ln_type,ln_time,ln_history,ln_history_w]
#        numInputs = outNeededValue['num_input_local'][0][0]
#        numOutputs = outNeededValue['num_output_local'][0][0]
#        return [minOutput,maxOutput,minInput,maxInput,numNodes,numLayers,layers,adMat,enabMat,listNodes,numInputs,numOutputs]
    
    def fAnn_zombie(self,stateSpace,minOutput,maxOutput,minInput,maxInput,numNodes,numLayers,layers,adMat,enabMat,listNodes,numInputs,numOutputs):
        numStates = np.size(stateSpace,0)
        stateSpace_dummy = []
        for i in range(0,numStates):
            stateSpace_dummy.append(float(stateSpace[i]))
        stateSpace = np.reshape(stateSpace,(numStates,1))
        sizeLayers = np.zeros(numLayers+10) # adding a buffer
        sizeLayers[0] = layers[0].shape[1]  # equal to size_layer(1)=size(l{1},2);
        sizeofLayers1 = int(sizeLayers[0])  # temp variabletateSpace, reward, done = env.step(Force)
        
        for j in range(0,numInputs-1):            
            stateSpace[j] = (stateSpace[j] - minInput[j])/(maxInput[j] - minInput[j])
        
        stateSpace = 2*(stateSpace - 0.5)
        stateSpace = np.vstack((stateSpace,1))
        v1 = np.zeros((300,300)) # sparse matrix used instead of a dict for matlab struct
        f1 = np.zeros((300,300))
        layer1 = layers[0][0] # equal to l{1}. Use this to give you l{1}(j) in first loop.
        Ft = np.zeros((numOutputs,1))
        Force = np.zeros((numOutputs,1))
        
        #======================================================================
        for j in range(0,sizeofLayers1):
            v1[0,j] = stateSpace[j]
            indexVar1 = layer1[j]-1 # TO GET CORRECT INDEX OF NEXT LINE
            listNodes[indexVar1][3][0][0] = v1[0,j]
            listNodeTime = int(listNodes[indexVar1][2])
            
            for it in range(0,listNodeTime):
                listNodeHistoryWeight = listNodes[indexVar1][4][0][it]
                listNodeHistory = listNodes[indexVar1][3][0][it]
                v1[0,j] += listNodeHistoryWeight*listNodeHistory
            for it in range(listNodeTime-1,1,-1):
                listNodes[indexVar1][3][0][it] = listNodes[indexVar1][3][0][it-1]
            f1[0,j] = v1[0,j]
        for il1 in range(1,numLayers):
            sizeLayers[il1] = layers[il1].shape[1]
            sizeofLayersX = int(sizeLayers[il1])
            for il2 in range(0,il1):
                for j1 in range(0,sizeofLayersX):
                    v1[il1,j1] = 0
                    sizeLayersil2 = int(sizeLayers[il2])                    
                    for j2 in range(0,sizeLayersil2):
                        tempVar1 = layers[il2][0][j2]-1
                        tempVar2 = layers[il1][0][j1]-1               
                        v1[il1,j1] += enabMat[tempVar1,tempVar2]*adMat[tempVar1,tempVar2]*f1[il2,j2]
                    tempVar2 = layers[il1][0][j1]-1
                    listNodes[tempVar2][3][0][0] = v1[il1,j1]
                    listNodeTime = int(listNodes[tempVar2][2])
                    for it in range(0,listNodeTime):
                        tempVar2 = layers[il1][0][j1]-1
                        listNodeHistoryWeight = listNodes[tempVar2][4][0][it]
                        listNodeHistory = listNodes[tempVar2][3][0][it]
                        v1[il1,j1] += listNodeHistoryWeight*listNodeHistory
                    
                    for it in range(listNodeTime-1,1,-1):
                        tempVar2 = layers[il1][0][j1]-1
                        listNodes[tempVar2][3][0][it] = listNodes[tempVar2][3][0][it-1]
                    tempVar2 = layers[il1][0][j1]-1
                    f1[il1,j1] = self.func_Ann(v1[il1,j1],listNodes[tempVar2][1][0])
                    if tempVar2 > numInputs-1 and tempVar2 <= numInputs+numOutputs-1:
                        Ft[tempVar2-numInputs] = f1[il1,j1]
        for i in range(0,numOutputs):
            Force[i] = Ft[i]*(maxOutput[i] - minOutput[i]) + minOutput[i]
        for i in range(0,numStates):
            stateSpace[i] = stateSpace_dummy[i]    
        return Force,listNodes,stateSpace
        
#    def myStep(self,action,state):
#        position = state[0]
#        velocity = state[1]
#        force = min(max(action, -1.0), 1.0)
#        velocity += force*0.0015 -0.0025 * math.cos(3*position)
#        if (velocity > 0.07): 
#            velocity = 0.07
#        if (velocity < -0.07): 
#            velocity = -0.07
#        position += velocity
#        if (position > 0.6): 
#            position = 0.6
#        if (position < -1.2): 
#            position = -1.2
#        if (position==-1.2 and velocity<0): 
#            velocity = 0
#        done = bool(position >= 0.45)
#        reward = 0
#        if done:
#            reward = 100.0
#        reward-= math.pow(action,2)*0.1
#        state = np.array([position, velocity])
#        return state, reward, done, {}
        
class MainSim():

    def mySimulate(self,genomeNumber,generationNumber):
        outNeededLocal = sio.loadmat('out_needed' + str(genomeNumber) + '.mat')
        # print(outNeededLocalX['out_needed_local'])
        out_needed = dict()

        out_needed ['min_output_local'] = outNeededLocal['out_needed_local']['min_output_local'][0][0][0]
        # print(out_needed ['min_output_local'])

        out_needed ['max_output_local'] = outNeededLocal['out_needed_local']['max_output_local'][0][0][0]
        #print(out_needed['max_output_local'])

        out_needed ['min_inp_local'] = outNeededLocal['out_needed_local']['min_inp_local'][0][0][0]
        #print(out_needed['min_inp_local'])

        out_needed ['max_inp_local'] = outNeededLocal['out_needed_local']['max_inp_local'][0][0][0]
        #print(out_needed['max_inp_local'])

        out_needed ['num_input_local'] = outNeededLocal['out_needed_local']['num_input_local'][0][0][0][0]
        #print(out_needed['num_input_local'])
        numInp = out_needed ['num_input_local']

        out_needed ['num_output_local'] = outNeededLocal['out_needed_local']['num_output_local'][0][0][0][0]
        #print(out_needed['num_output_local'])
        numOut = out_needed ['num_output_local']

        out_needed ['n_l_local'] = outNeededLocal['out_needed_local']['n_l_local'][0][0][0][0]
        #print(out_needed['n_l_local'])

        out_needed ['l_local'] = dict()
        for i in range(1,out_needed['n_l_local']+1):
            out_needed ['l_local'][i] = dict()
            for j in range(1,len(outNeededLocal['out_needed_local']['l_local'][0][0][0][i-1][0])+1):
                out_needed['l_local'][i][j] = outNeededLocal['out_needed_local']['l_local'][0][0][0][i-1][0][j-1]
                # print(outNeededLocal['out_needed_local']['l_local'][0][0][0][i-1][0][j-1])
                # out_needed['l_local'][i][j] = outNeededLocal['out_needed_local']['l_local'][0][0][0][i-1][j-1]
        # print(out_needed['l_local'])
        # sads


        out_needed ['w_local'] = outNeededLocal['out_needed_local']['w_local'][0][0]
        #print(out_needed['w_local'])

        out_needed ['e_local'] = outNeededLocal['out_needed_local']['e_local'][0][0]
        #print(out_needed['e_local'])

        out_needed ['n_n_local'] = outNeededLocal['out_needed_local']['n_n_local'][0][0][0][0]
        #print(out_needed['n_n_local'])

        F_BEST_TILL_NOW = outNeededLocal['out_needed_local']['F_best_till_now'][0][0][0][0]
        if abs(F_BEST_TILL_NOW)<.1 and F_BEST_TILL_NOW<0:
            F_BEST_TILL_NOW = -.1
        if abs(F_BEST_TILL_NOW)<.1 and F_BEST_TILL_NOW>0:
            F_BEST_TILL_NOW = -.1
        # print(F_BEST_TILL_NOW)

        # #print(80*'\n')
        out_needed ['list_node'] = dict()
        for i in range(1,out_needed['n_n_local']+1):
            out_needed ['list_node'][i] = dict()
            out_needed ['list_node'][i]['list_node_ID'] = outNeededLocal['out_needed_local']['list_node'][0][0][0][i-1]['list_node_ID'][0][0]
            out_needed ['list_node'][i]['list_node_type'] = outNeededLocal['out_needed_local']['list_node'][0][0][0][i-1]['list_node_type'][0][0]
            out_needed ['list_node'][i]['list_node_time'] = outNeededLocal['out_needed_local']['list_node'][0][0][0][i-1]['list_node_time'][0][0]

            out_needed ['list_node'][i]['list_node_history'] = dict()
            for j in range(1,len(outNeededLocal['out_needed_local']['list_node'][0][0][0][i-1]['list_node_history_W'][0])+1):
                # out_needed ['list_node'][i]['list_node_history'][j] = outNeededLocal['out_needed_local']['list_node'][0][0][0][i-1]['list_node_history'][0][j-1]
                out_needed ['list_node'][i]['list_node_history'][j] = 0

            out_needed ['list_node'][i]['list_node_history_W'] = dict()
            for j in range(1,len(outNeededLocal['out_needed_local']['list_node'][0][0][0][i-1]['list_node_history_W'][0])+1):
                out_needed ['list_node'][i]['list_node_history_W'][j] = outNeededLocal['out_needed_local']['list_node'][0][0][0][i-1]['list_node_history_W'][0][j-1]
            # sadas
            # print(out_needed ['list_node'][i]['list_node_history'])
            # print(out_needed ['list_node'][i]['list_node_history_W'])
            # print('XXXXXXXXXXXXXXXX')
            #

        # outNeededLocalX =copy.deepcopy(outNeededLocalX['out_needed_local'])
        # print(outNeededLocalX)

        # print(outNeededLocal['min_output_local'])

        #outNeededLocal = sio.loadmat('BEST.mat')
        totTotReward = 0
        numEpisodes = 5
        totalRewardVec = np.zeros((numEpisodes,1))
        counter_AMIR = 0
        totalStepCounter = 0
        total_AMIR_reward=0
        tempNN = NN()
        for i in range(0,numEpisodes):
            counter_AMIR += 1
            env = Continuous_MountainCarEnv()
            #env = wrappers.Monitor(env, '/home/sharatpa')# aaddres s to save # enough for save Needs different directories, even if names are diffenerent
            env.reset()
            action = random.uniform(-1,1)
            # print(outNeededLocal)

            # print('XXXX1')
            # print(numInp)
            # print('XXXX2')
            # sad
            #minOut,maxOut,minInp,maxInp,numNodes,numLayers,layers,adMat,enabMat,listNodes,numInp,numOut = tempNN.prefANN(outNeededLocal)
            # minOut,maxOut,minInp,maxInp,numNodes,numLayers,layers,adMat,enabMat,listNodes,numInp,numOut = prefAnn.prefAnn_f(outNeededLocal)
            Desired_fitness = []
            timeStep = 0
            done = False
            stateSpace, reward, done, info = env.step(action)
            timeStep += 1
            totalStepCounter += 1
            totalRewardVec[i] += reward
            inp = np.zeros(shape=[numInp+1,1])

            # Rezero History
            for iX in range(1,out_needed['n_n_local']+1):
                for j in range(1,len(outNeededLocal['out_needed_local']['list_node'][0][0][0][iX-1]['list_node_history_W'][0])+1):
                    out_needed ['list_node'][iX]['list_node_history'][j] = 0

            while timeStep <= 999:
                stateSpace, reward, done, info = env.myStep(action,stateSpace)
                stateSpace1, reward1, done1, info = env.step(action)
                reward = float(reward)
                #Force,listNodes,stateSpace = tempNN.fAnn_zombie(stateSpace,minOut,maxOut,minInp,maxInp,numNodes,numLayers,layers,adMat,enabMat,listNodes,numInp,numOut)
                #Force,listNodes,stateSpace = fAnn.fAnn_f(stateSpace,minOut,maxOut,minInp,maxInp,numNodes,numLayers,layers,adMat,enabMat,listNodes,numInp,numOut)

                for jj in range(1,numInp-1+1):
                    inp[jj] = copy.deepcopy(stateSpace[jj-1])

                [actionX,out_needed] = fAnn.fAnn_f(inp,out_needed)
                for jj in range(1,numOut+1):
                    action = copy.deepcopy(actionX[0][jj])
                # print(action)

                #env.render()
                action = float(action)
                # print('Force =',Force)
                # print('StateSpace = ',stateSpace)
                timeStep += 1
                totalStepCounter += 1
                totalRewardVec[i] += reward
                # print(timeStep)
                if done:
                    print(timeStep)
                    #env.render()# enough for see
                    break
            totTotReward = copy.deepcopy(np.mean(totalRewardVec[0:i]))
            if (F_BEST_TILL_NOW > 0):
                if (np.mean(totalRewardVec[0:i])/F_BEST_TILL_NOW < 0.8 ):
                    break
            else:
                if (np.mean(totalRewardVec[0:i])/F_BEST_TILL_NOW > (1/0.8)):
                    break


        totReward = {}
        totReward['totalReward'] = totTotReward
        totReward['counter_Amir'] = counter_AMIR
        totReward['totalStepCounter'] = totalStepCounter
        sio.savemat('Reward' + str(genomeNumber) + '.mat',totReward)

#        print(totalRewardVec)
#        print(totTotReward)
        return totTotReward
