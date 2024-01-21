function [MSE,NRMSE,NRMSEvector,SimulationTraj]=Simulation_Ref(obj,Ref_Traj)
 
 inputflag=(size(Ref_Traj{1},2)~=obj.Initialize.systemstatedimension*obj.Initialize.systemorder);
 NormalizedSimulationTraj=cell(1,size(Ref_Traj,2));
 for i = 1:size(Ref_Traj,2) 
          NomalizedInput=mapminmax('apply',[zeros(obj.Initialize.statedimension*(obj.Initialize.systemorder-1),size(Ref_Traj{i},2));Ref_Traj{i}],obj.Initialize.input_ps);  
          NormalizedExternalInput=NomalizedInput(obj.Initialize.statedimension*(obj.Initialize.systemorder)+1:end,:);    
          NormalizedSimulationTraj{i}=zeros(size(Ref_Traj{i}));
          for j=1:obj.Initialize.systemorder
            StateInput((j-1)*obj.Initialize.systemstatedimension+1:j*obj.Initialize.systemstatedimension,1)=Ref_Traj{i}(1:obj.Initialize.systemstatedimension,j);
          end
          if(inputflag)
                tempNNinput=mapminmax('apply',[StateInput;Ref_Traj{i}(obj.Initialize.systemstatedimension*obj.Initialize.systemorder:end,1+obj.Initialize.systemorder-1)],obj.Initialize.input_ps);
          else
                tempNNinput=mapminmax('apply',StateInput,obj.Initialize.input_ps);
          end
          
          for j=1:obj.Initialize.systemorder              
             %for z=1:j-1
              %   NNinput(obj.Initialize.systemstatedimension*(z-1)+1:obj.Initialize.systemstatedimension*z)=NormalizedSimulationTraj();
             %end 
             NormalizedSimulationTraj{i}(:,j)=tempNNinput((j-1)*obj.Initialize.systemstatedimension+1:j*obj.systemstatedimension,:);         
          end
          NNinput=zeros(size(tempNNinput));
          for j=obj.Initialize.systemorder+1:size(Ref_Traj{i},2)
             for k=1:obj.Initialize.systemorder
                NNinput((k-1)*obj.Initialize.systemstatedimension+1:(k)*obj.Initialize.systemstatedimension,:)=NormalizedSimulationTraj{i}(:,j-k);
             end
             if(inputflag)
              NNinput(obj.Initialize.systemstatedimension*obj.Initialize.systemorder+1:end,:)=NormalizedExternalInput(:,j);
             end
             outputflag=1;
             for k = 1:size(obj.P1.intervals,2)
                 for z = 0:obj.Initialize.systemstatedimension:size(obj.P1.intervals{k},1)-obj.Initialize.systemstatedimension
                       if(partitions.ifin(obj.Initialize.coeff(:,1:obj.Initialize.idx)'*(NNinput(1:obj.Initialize.systemstatedimension*obj.Initialize.systemorder)-obj.Initialize.mu'),obj.P1.intervals{k}(z+1:z+obj.Initialize.systemstatedimension,:),obj.Initialize.maximum_dimension)==1)
                           NormalizedSimulationTraj{i}(:,j)= ELMpredict(obj.ELMs1(k),NNinput);
                           outputflag=0;
                       end             
                 end
             end
             if(outputflag)
              NormalizedSimulationTraj{i}=NormalizedSimulationTraj{i}(:,1:j);
              break;
             end
          end
     SimulationTraj{i}=mapminmax('reverse',NormalizedSimulationTraj{i},obj.Initialize.output_ps);
 end

%% Evaluation and Plot Figures 
% 1.MSE
Error=0;
Num=0;
for i =1:size(SimulationTraj,2)
    for j = 1:size(SimulationTraj{i},2)
       for k = 1:size(SimulationTraj{i},1)
        Error=Error+(SimulationTraj{i}(k,j)-Ref_Traj{i}(k,j))^2;
       end
    end
    Num=Num+size(SimulationTraj{i},2);
end
MSE=1/Num*(Error);
% 2.NRMSE

RefTrajMatrix=[];
SimTrajMatrix=[];
for i = 1:size(Ref_Traj,2)
   %[m,n]=size(SimulationTraj{i});
   %Num=m*n+Num; 
   %diff=SimulationTraj{i}-Ref_Traj{i}(1:size(SimulationTraj{i},1),1:size(SimulationTraj{i},2));
   %squaredDifference=diff.^2;
   %sumOfSquaredElements = sum(squaredDifference(:))+ sumOfSquaredElements;
   SimTrajMatrix=[SimTrajMatrix SimulationTraj{i}];
   RefTrajMatrix=[RefTrajMatrix Ref_Traj{i}(1:size(SimulationTraj{i},1),1:size(SimulationTraj{i},2))];
end
NRMSEvector=zeros(size(SimTrajMatrix,1),1);
for i=1:size(SimTrajMatrix,1) 
    difference = SimTrajMatrix(i, :) - RefTrajMatrix(i, :);
    mse = mean(difference .^ 2);
    rmse = sqrt(mse);
    stdA = std(RefTrajMatrix(i, :));
    NRMSEvector(i,1) = rmse / stdA;
end
Res=SimTrajMatrix-RefTrajMatrix;
clear SimTrajMatrix RefTrajMatrix
RMSEA= sqrt(mean(Res(:).^2));
stdA= std(Res(:));
clear Res
NRMSE=RMSEA/stdA;
       
%% Figure
figure
if (size(SimulationTraj{1},1)==2)
 for i=1:size(SimulationTraj,2)
    plot(SimulationTraj{i}(1,:),SimulationTraj{i}(2,:),'*')
    hold on 
    plot(Ref_Traj{i}(1,:),Ref_Traj{i}(2,:),'o')
    hold on
 end
else
 for i = 1:size(SimulationTraj,2) 
   for j = 1:obj.Initialize.systemstatedimension
       subplot(SystemStateDimension,1,j)
       plot(1:size(SimulationTraj{i},2),SimulationTraj{i}(j,:),'*')
       hold on
       plot(1:size(Ref_Traj{i},2),Ref_Traj{i}(j,:),'o')
       xlabel('time')
       ylabel('trajecotries')
   end
 end
end