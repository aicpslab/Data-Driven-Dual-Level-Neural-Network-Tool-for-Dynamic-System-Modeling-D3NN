# Data-Driven Dual-Level Neural Network Tool for Dynamic System Modeling (D3NN)

# Introduction

Data-Driven Dual Level Neural Network (D3NN) is a powerful MATLAB toolkit designed for dynamic system modeling using advanced neural network techniques. This tool integrates data-driven methodologies with a dual-level neural network structure including low-level neural hybrid systems and high-level transition system abstraction to provide accurate and efficient modeling capabilities for various dynamic systems. 

# Features

- **Data-Driven Approach:** Utilizes data to model dynamic systems, ensuring accuracy and relevance.
- **Low-level Neural Hybrid System Modeling:** Low-level neural hybrid system modeling process allows multiple ELMs to be trained and verified. Compared with conventional NN learning, this structure promotes computationally efficiency while maintaining accuracy in dynamics learning.  
- **High-level Transition System Abstraction:**  Based on the low-level neural hybrid system model, the high-level transition system abstraction allows fast and CTL language-based verification, which not only reveals the transitions inside the black-box model but also allows user-friendly language input verification. 


# Installation

To install D3NN, follow these simple steps:

1. Clone or download the D3NN repository.

2. Add the D3NN folder to your MATLAB path.
- **Open MATLAB and navigate to the D3NN folder.**
- **Right-click on the folder in MATLAB's "Current Folder" window.**
- **Select "Add to Path" > "Selected Folders and Subfolders".**

# Dependencies

The Data-Driven Dual Level Neural Network Tool for Dynamic System Modeling (D3NN) relies on several external MATLAB toolboxes for full functionality. Please ensure that you have the following toolboxes installed and added to your MATLAB path:

## GLPKMEX

GLPKMEX is a MATLAB interface for the GNU Linear Programming Kit. This toolbox is essential for solving linear programming and mixed integer linear programming problems within D3NN.

## NNV

NNV stands for Neural Network Verification. This toolbox is used in D3NN for performing verification tasks on neural networks, ensuring the reliability and robustness of the models.

## YALMIP

YALMIP is a high-level modeling language for advanced modeling and solution of optimization problems. D3NN utilizes YALMIP for optimization tasks.

# Adding Toolboxes to MATLAB Path

After installing these toolboxes, add them to your MATLAB path. This can be done by navigating to the toolbox directory in MATLAB and using the `addpath` command.

# Usage
Here's how to get started with D3NN in MATLAB. User can

- **Open ...\The Neural Network Learning Tool for Dual-Level Dynamic System Modeling (D3NN)\Runtest4D3NN.mlx to run an example of the encapsulated Dual-level Data-driven modeling using class methods.**
- **Open ...\The Neural Network Learning Tool for Dual-Level Dynamic System Modeling (D3NN)\Runtest.mlx to run detailed NHS modeling and transition system abstraction process.**

## Process

### 1. Initialization and Load Data

D3NN allows higher-order modeling of the given data set by setting **SystemOrder>1**.

**Maximum_Dimension** determines PCA mapping space dimension.

**SystemStateDimension** is the state dimension in the dataset.

**tol** sets the minimum bound length tolerance for the Maximum Entropy Partitioning method in NHS modeling.

**maximum_entropy** sets the tolerance for Maximum Entropy ME partitioning in NHS modeling.

**NeuronNum_switch** sets the neuron number in the hidden layer of ELM in NHS.

**TF** is the transfer function of ELM in NHS.

**timetic** sets the staying steps in each cell when transferred into the UPPAAL model.

**e** sets the tolerance when merging the redundant partitions.

**VerificationNum** sets the verification number of the randomly generated trajectories when showing the approximation ability of NHS.

**VerificationDuration** sets the verification duration of the randomly generated trajectories when showing the approximation ability of NHS.

**InitialBound** sets the randomly generated initial state bound when running simulations to show the approximation ability of NHS.

**VerificationU_input** sets the randomly generated external input bound when running simulations to show the approximation ability of NHS.

**AbstractionNum** sets the verification number of the randomly generated trajectories in NTS abstraction.

**AbstractionDuration** sets the verification duration of the randomly generated trajectories in NTS abstraction.

**AbstractionTol** sets the minimum bound length tolerance for the Maximum Entropy Partitioning method in high-level transition system abstraction.  

**AbstractionEntropy** sets the tolerance for Maximum Entropy ME partitioning in transition system abstraction.

**SelfLoopNum** sets the reduced selfloop number in transition system abstraction.

### 2. Neural Hybrid System Learning

**NHS(xsn,tn,Ini):** Generate the NHS model with the normalized input and output set and the initialized coefficients.

**SamplesnPartitionsPlot(NHS1,xsn):** Plot partitions and samples of NHS1 and mapminmaxed samples.
![image](https://github.com/aicpslab/Data-Driven-Dual-Level-Neural-Network-Tool-for-Dynamic-System-Modeling-D3NN/blob/main/Example/SamplesnPartitions.png)

**PoltDataPartition(NHS1):** Plot merged partitions of NHS1.
![image](https://github.com/aicpslab/Data-Driven-Dual-Level-Neural-Network-Tool-for-Dynamic-System-Modeling-D3NN/blob/main/Example/MergedPartitions.png)

**PredictionPlot(NHS1,xsn,tn)** Plot the prediction results using the mapminmaxed data set as the NHS input.
![image](https://github.com/aicpslab/Data-Driven-Dual-Level-Neural-Network-Tool-for-Dynamic-System-Modeling-D3NN/blob/main/Example/PredictionMode.png)

**Runsimulation(NHS1)** Run NHS1 simulation with randomized initial state input and external input and return the randomly generated external input and trajectories.

![image](https://github.com/aicpslab/Data-Driven-Dual-Level-Neural-Network-Tool-for-Dynamic-System-Modeling-D3NN/blob/main/Example/SimulationMode.png)

### 3. Transition System Abstraction

**NTS(NHS1)** Generated a transition system abstraction based on NHS1.

**TransitionCompute(NTS1)** Compute the transition relationship of the transition system NTS1 and generated a transition graph.

![image](https://github.com/aicpslab/Data-Driven-Dual-Level-Neural-Network-Tool-for-Dynamic-System-Modeling-D3NN/blob/main/Example/TransitionGraph.png)

**ReduceSelfloop(NTS1)** Reduced the self-loop number under the  for all trajectories limited staying = no self-loop assumption and returned a reduced-self-loop transition map.

![image](https://github.com/aicpslab/Data-Driven-Dual-Level-Neural-Network-Tool-for-Dynamic-System-Modeling-D3NN/blob/main/Example/ReducedTransitionGraph.png)

**CTLFormulaeInput(NTS1)** User interface of generating the specifications including initial cell and CTL formulae, based on the transition map.

![image](https://github.com/aicpslab/Data-Driven-Dual-Level-Neural-Network-Tool-for-Dynamic-System-Modeling-D3NN/blob/main/Example/Interface.png)

**GenerateSystem(NTS1)** Generated a UPPAAL readable file with a user-defined name.

### 4. UPPAAL & Verification
Open the user-saved file with UPPAAL
![image](https://github.com/aicpslab/Data-Driven-Dual-Level-Neural-Network-Tool-for-Dynamic-System-Modeling-D3NN/blob/main/Example/UPPAAL%20Model.png)
![image](https://github.com/aicpslab/Data-Driven-Dual-Level-Neural-Network-Tool-for-Dynamic-System-Modeling-D3NN/blob/main/Example/CTLverification.png)
# Contact
For any questions or feedback, please reach out to us at yangyejiang0316@163.com.
