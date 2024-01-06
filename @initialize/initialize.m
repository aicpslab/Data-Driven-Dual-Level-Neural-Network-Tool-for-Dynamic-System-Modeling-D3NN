classdef initialize
    % feedforward class
    %
    % Syntax:
    %    object constructor: Obj = ffnetwork(w,b,a)
    %    copy constructor: Obj = otherObj
    %
    % Inputs:
    %    input1 - weight, cell{matrix}
    %    input2 - bias, cell{vector}
    %    input3 - activation function, cell{string}
    %
    % Outputs:
    %    Obj - Generated Object
    %
    
    % Author:       Weiming Xiang
    % Written:      02/25/2019
    % Last update:  09/13/2019
    
%------------- BEGIN CODE --------------
    
    properties
        systemorder={};
        maximum_dimension={};
        systemstatedimension={};
        tol = {};
        maximum_entropy={};
        neuronnum_switch={};
        neuronnum_single={};
        tf={};
        timetic={};
        e={}; % Expected Merged Tolerence
        verificationnum={};  
        verificationduration={};
        trainingstatedimension={};
        initialbound={};
        verificationu_input={};
        abstractionnum={};
        abstractionduration={};
        % Decrease Self Loop Num
        selfloopNum={};
        mu={};
        coeff={};
        explained={};
        mode={};
        idx={};
        name={};
        input_ps={};
        output_ps={};
    end
    
    methods
        %% class constructor
        function obj = initialize(SystemOrder,Maximum_Dimension,SystemStateDimension,tol,maximum_entropy,NeuronNum_switch,NeuronNum_single,TF,timetic,e,VerificationNum,VerificationDuration,TrainingStateDimension, InitialBound,VerificationU_input,AbstractionNum,AbstractionDuration,SelfLoopNum,Mode,idx,name)
            obj.systemorder=SystemOrder;
            obj.maximum_dimension=Maximum_Dimension;
            obj.systemstatedimension=SystemStateDimension;
            obj.tol = tol;
            obj.maximum_entropy=maximum_entropy;
            obj.neuronnum_switch=NeuronNum_switch;
            obj.neuronnum_single=NeuronNum_single;
            obj.tf=TF;
            obj.timetic=timetic;
            obj.e=e; % Expected Merged Tolerence
            obj.verificationnum=VerificationNum;
            obj.verificationduration=VerificationDuration;
            obj.trainingstatedimension=TrainingStateDimension;
            obj.initialbound=InitialBound;
            obj.verificationu_input=VerificationU_input;
            obj.abstractionnum=AbstractionNum;
            obj.abstractionduration=AbstractionDuration;
            % Decrease Self Loop Num
            obj.selfloopNum=SelfLoopNum;
            obj.mode=Mode;
            obj.idx=idx;
            obj.name=name;
        end
        
        %% methods in seperate files

        % Turn Dataset into Samples
        [xs,t] = dataset2samples(obj,dataset)

        % generate numInput random outputs for an input interval inputInterval
        [xsn,tn,input_ps,output_ps] = samplesmapminmax(obj,xs,t)
        
        % Generate mapminmaxed samples with no input
        xsnu=samplesnoinput(obj,xsn);

        % Getting PCA coefficient
        [coeff,mu] = samplespca(obj,xsnu)
       
        IntersetSet = decreaseselfloop(obj,IntersectSet,demos)

        flag=selfless(obj,demos,interval,Num)
       
        obj=updatepca(obj,coeff,mu)

        [xsn,xsnu,tn,input_ps,output_ps,coeff,mu]=initializingdata(obj,dataset)

  
    end
         methods(Static)
        % Turn Trajectories into Dataset
             dataset = trajectories2dataset(Trajectories)
        end
end
%------------- END OF CODE --------------
    
    
    
    
