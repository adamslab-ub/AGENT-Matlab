# AGENT-Matlab

Adaptive Genomic Evolution of Neural-Network Topologies (AGENT)

This new algorithm, called the Adaptive Genomic Evolution of Neural Network Topologies (AGENT), builds on the neuroevolution of augmenting topologies (NEAT) concept. Neuroevolution is an approach to use a special kind of genetic algorithm to design or train artificial neural networks, with the NEAT concept being particularly capable of jointly optimizing the structure and parameters (e.g., weights) of the neural network. It can be perceived as simultaneous neural architecture search and network training. In AGENT, novel mechanisms for adapting the selection and mutation operations are implemented to favorably control population diversity and exploration/exploitation balance. 
Further advancements to the NEAT paradigm occur through the incorporation of variable neuronal properties and new mutation operations that uniquely allow both the growth and pruning of ANN topologies during evolution. 

This repository contains the code for the implementation of Adaptive Genomic Evolution Neural-Network Topologies aka AGENT, for evolutionary reinforcment learning. 

How to use the code:

    Learning:
    
        To run the test mountain car code run AGENT_main.file. The init_user_specified_variables.m can be used to set the problem and the learning settings.
        Using this file the number of generations, the population and the learning problem can be defined.
        
        Other parameters which can be changed and alter the algorithm behaviour are in init_hyperparameter-variables.
        
        The population in each step of each generations are saved in  "SAVE_TOCHECK_MAT"num2str(run_step)+ on +num2str(0)+.mat" files.
        
        The code uses CPU only but it can use multiprocessing. Inorder to turn multiprocessing on/off use init_user_specified_variables.m file.
               

    Evaluation:
        The sample code uses Countinous Montain Car from OpenAI Gym, but the code can be modified for other problems from Python (like the example code) or Mtalab              environments. When a new problem is used, the range of inputs and outputs should be set in init_user_specified_variables.m.

    Dependencies:
        The code is written in Matlab. We recommend using Matlab R2019b or newer since we tested in these versions but previous versions of Matlab might be acceptable          too. 

    Citation:

        Please cite our work if you find it useful.
Behjat, Amir, et al. "Adaptive Neuroevolution With Genetic Operator Control and Two-Way Complexity Variation." IEEE Transactions on Artificial Intelligence (2022).

    
    Bibtex: 
           @article{behjat2022adaptive,
           title={Adaptive Neuroevolution With Genetic Operator Control and Two-Way Complexity Variation},
           author={Behjat, Amir and Maurer, Nathan and Chidambaran, Sharat and Chowdhury, Souma},
           journal={IEEE Transactions on Artificial Intelligence},
           year={2022},
           publisher={IEEE}}


If you have any questions or concerns, please raise an issue or email: namaurer@buffalo.edu
                
                
