classdef NHS
    properties
        Initialize={};
        ELMs={};
        ELMs1={};
        P={};
        P1={};
        Boundaries={};
    end
methods
    function obj=NHS(xsn,tn,Initialize)
       obj.Initialize=Initialize;
           datasetn1=Initialize.coeff'*(xsn-Initialize.mu');
           datasetn=datasetn1';
           bounds=zeros(size(Initialize.coeff,2),2);
           for i=1:size(Initialize.coeff,2) 
                bounds(i,1)=min(datasetn(:,i))-0.2;
                bounds(i,2)=max(datasetn(:,i))+0.2;
           end
        init_interval{1}=bounds;
        xsnu=samplesnoinput(Initialize,xsn)';
        P = partitions(init_interval,xsnu',tn');
        %% ME Partitions
        intervals=ME(P,Initialize.tol,Initialize.maximum_entropy,Initialize.maximum_dimension,Initialize.mu',Initialize.coeff');
        P.intervals=intervals;
        P.input=xsn';
        obj.P=P;
        %% Merging
        ELMs1=ELM.GenerateELM(size(xsn,1),Initialize.neuronnum_switch,Initialize.tf,size(tn,1)); 
        [obj.P1,ELMs]=MergePatitions(P,ELMs1,Initialize.e,Initialize.mu',Initialize.coeff',size(xsnu,1));
        obj.ELMs=ELMs;
        mse_switch = 0;
        min_mse_switch=1;
        for i = 1:size(ELMs,2)
            if (mse_switch<ELMs(i).trainingError)
                    mse_switch = ELMs(i).trainingError;
            end
            if (min_mse_switch>ELMs(i).trainingError)
                    min_mse_switch = ELMs(i).trainingError;
            end
        end
        fprintf('the maximum training error using the normalized model is');
        disp(mse_switch); 
        ELMs1=ELM.GenerateELM(size(xsn,1),Initialize.neuronnum_single,Initialize.tf,size(tn,1));
        ELMs1=trainELM(ELMs1,xsn,tn);
        obj.ELMs1=ELMs1;
    end
  SamplesnPartitionsPlot(obj,xsn)
  PredictionPlot(obj,xsn,tn)
  InitialState=GenerateInitialState(obj)
  [MSE,NRMSE,NRMSEvector,SimulationTraj]=Simulation_Ref(obj,Ref_Traj)
  [RandomInput,SimulationTraj]=Runsimulation(obj)
  PoltDataPartition(obj)
  
  obj=NHSLearning(xsn,tn,Ini)


end
end
   