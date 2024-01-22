classdef NTS
    properties
        NHS={};
        P={};
        TransitionMap={};
        ReducedTransitionMap={};
        InputCTLformulae={};
        demostrate={};
        InitialCell={};
        Name={};
    end
methods
    function obj=NTS(NHS)
        SystemOrder=NHS.Initialize.systemorder;
        SystemStateDimension=NHS.Initialize.systemstatedimension;
        idx=NHS.Initialize.idx;
        coeff=NHS.Initialize.coeff;
        mu=NHS.Initialize.mu;
        segmentIndex=NHS.P1.intervals;
        obj.NHS=NHS;
        Maximum_Dimension=NHS.Initialize.maximum_dimension;
        ps_input=NHS.Initialize.input_ps;
        ps_output=NHS.Initialize.output_ps;
        AbstractionDuration=NHS.Initialize.abstractionduration;
    % 1. Generating Abstraction Samples
          BoundInterval=[NHS.Initialize.input_ps.xmin,NHS.Initialize.input_ps.xmax];
            RandomStateInput = intervalCompute.randomPoint(BoundInterval,NHS.Initialize.abstractionnum);
            RandomStateInput = mapminmax('apply', RandomStateInput,ps_input); 
            for j =1:NHS.Initialize.abstractionnum  
                        for l =1:NHS.Initialize.systemorder
                            Traj_Abstraction_switch{j}(:,l)=RandomStateInput((l-1)*NHS.Initialize.systemstatedimension+1:l*NHS.Initialize.systemstatedimension,j);
                        end
                    flag=0;
                for i =NHS.Initialize.systemorder+1:NHS.Initialize.abstractionduration
                    for l = 1:NHS.Initialize.systemorder
                      if(size(Traj_Abstraction_switch{j},2)==i-1)
                        Traj_Abstraction_switchinput((l-1)*SystemOrder+1:l*SystemStateDimension,:)=Traj_Abstraction_switch{j}(:,i-l);
                        flag=1;
                      else
                        flag=0;
                      end                 
                    end
                    if(flag)
                         InputNs=[Traj_Abstraction_switchinput;zeros(size(NHS.Initialize.input_ps.xmin,1)-SystemStateDimension*SystemOrder,1)];
                         demostrate{1,j}(:,i-SystemOrder)=InputNs;
                    end
                   % InputN=mapminmax('apply',[Traj_Abstraction_singleinput;zeros(size(xsn,1)-SystemStateDimension*SystemOrder,1)],ps_input);
                   InputN=[Traj_Abstraction_switchinput;zeros(size(NHS.Initialize.input_ps.xmin,1)-SystemStateDimension*SystemOrder,1)];
                    if (size(NHS.Initialize.input_ps.xmin,1)-SystemStateDimension*SystemOrder)
                        u_input=-1 + 2*rand(size(NHS.Initialize.input_ps.xmin,1)-SystemStateDimension*SystemOrder,1);
                        InputNs= [InputNs(1:SystemOrder*SystemStateDimension);u_input];
                    else 
                        InputNs= [InputNs(1:SystemOrder*SystemStateDimension)];
                    end
                    
                    %Traj_Abstraction_single{j}(:,i)=mapminmax('reverse',Traj_Abstraction_singleN,ps_output);
                    if(flag)
                        for k = 1:size(segmentIndex,2)
                              if(partitions.ifin(coeff(:,1:idx)'*(InputNs(1:SystemOrder*SystemStateDimension,:)-mu'),segmentIndex{k},Maximum_Dimension)==1)
                                       Traj_Abstraction_switchN= ELMpredict(NHS.ELMs(k),InputNs);
                                       %Traj_Abstraction_switch{j}(:,i)=mapminmax('reverse',Traj_Abstraction_switchN,ps_output);
                                       Traj_Abstraction_switch{j}(:,i)=Traj_Abstraction_switchN;
                              end
                        end
                    end 
                end
            end

            figure
            for j =1:size(Traj_Abstraction_switch,2)
                for i = 1:SystemStateDimension
                     subplot(SystemStateDimension,1,i)
                     plot(1:size(Traj_Abstraction_switch{j},2),Traj_Abstraction_switch{j}(i,:))
                     hold on
                        xlabel('time(s)')
                        ylabel('position')
                        hold on              
                end
            end
            title('Generated Abstraction Trajectories')
          
            if (size(Traj_Abstraction_switch{j},1)==2)
                figure
                for i = 1:size(Traj_Abstraction_switch,2)
                        plot(Traj_Abstraction_switch{i}(1,:)',Traj_Abstraction_switch{i}(2,:)','*')
                        hold on 
                        title('2-D Generated Abstraction Trajectories')
                end
            end 
TrajNum=size(Traj_Abstraction_switch,2);
EndMark=1;
for i = 1:TrajNum
    if(size(Traj_Abstraction_switch{i},2)==AbstractionDuration)
        Begin=EndMark;
        End = EndMark+(size(Traj_Abstraction_switch{i},2)-1);    
        for k= 1:SystemStateDimension
                SampleOutputSwitch(Begin:End-SystemOrder,k) = Traj_Abstraction_switch{i}(k,SystemOrder+1:end);
            for j = 1:SystemOrder
                SampleInputSwitch(Begin:End-SystemOrder,SystemStateDimension*(j-1)+k) = Traj_Abstraction_switch{i}(k,j:end-SystemOrder+j-1);            
            end
        end
        EndMark=End+1;
    elseif(size(Traj_Abstraction_switch{i},2)>SystemOrder)
        Begin=EndMark;
        End = EndMark+(size(Traj_Abstraction_switch{i},2)-2);
        for k= 1:SystemStateDimension
                SampleOutputSwitch(Begin:End-SystemOrder,k) = Traj_Abstraction_switch{i}(k,SystemOrder+1:end-1);
            for j = 1:SystemOrder
                SampleInputSwitch(Begin:End-SystemOrder,SystemStateDimension*(j-1)+k) = Traj_Abstraction_switch{i}(k,j:end-SystemOrder+j-2);            
            end
        end 
        EndMark=End+1;
    end
end
 
if (size(Traj_Abstraction_switch{1},1)~=SystemStateDimension)
    for i=1:TrajNum
        externalinput=Traj_Abstraction_switch{i}(SystemStateDimension+1:end,:)';
        SampleInputSwitch=[SampleInputSwitch externalinput];
    end
end

InputN=SampleInputSwitch';%mapminmax('apply',SampleInputSwitch',ps_input);
OutputN=SampleOutputSwitch';%mapminmax('apply',SampleOutputSwitch',ps_output);
Inputnu=InputN(1:SystemOrder*SystemStateDimension,:)'; 
    utest = (Inputnu-mu)*coeff(:,1:idx);
    bounderies = zeros(idx,2);
    for i= 1:idx
        bounderies(i,1)=min(utest(:,i))-0.2;
        bounderies(i,2)=max(utest(:,i))+0.2;
    end
    lowerbound=bounderies(:,1);
    upperbound= bounderies(:,2);
    init_interval{1}=bounderies;
    % 2. Obtain the Abstraction Cells
    tol=NHS.Initialize.abstractiontol;
    maximum_entropy=NHS.Initialize.abstractionentropy;
    P=partitions(init_interval,InputN',OutputN');
    intervals=ME(P,tol,maximum_entropy,Maximum_Dimension,mu',coeff(:,1:idx)');
    obj.P.intervals=intervals;
    obj.P.input=InputN;
    if size(intervals{1},1)==2
    figure
      partitions.intervalplot(intervals,'empty','b')
    grid on
    end
    obj.demostrate=demostrate;
%     % 3. Transition Relationship Computation
%     IntersectSet= zeros(size(intervals,2));
%     for i = 1: size(intervals,2)
%         for j = 1: size(intervals,2)
%             tic
%             I=intervals{j};    
%             for z=1:size(NHS.P1.intervals,2)
%                 for l=0:Maximum_Dimension:size(NHS.P1.intervals{z},1)-1
%                     Lowerbound=max([intervals{j}(:,1)';NHS.P1.intervals{z}(l+1:l+Maximum_Dimension,1)'])';
%                     Upperbound=min([intervals{j}(:,2)';NHS.P1.intervals{z}(l+1:l+Maximum_Dimension,2)'])';
%                     if(min(Lowerbound<Upperbound))
%                         Intersectflag = ifNextIntersect(NHS.ELMs(z),intervals{i},[Lowerbound,Upperbound]);
%                               if(Intersectflag)
%                                 IntersectSet(i,j)=1;
%                               end
%                     end
%                 end
%             end
%             toc
%         end
%     end
% 
% % 4. Generating Abstraction Graph
% obj.TransitionMap=IntersectSet;
% ModelGraph=digraph(IntersectSet);
% figure
% plot(ModelGraph,'b')
% 5.Decrease    
    end


  obj=TransitionCompute(obj)
  obj=ReduceSelfloop(obj,demostrate)
  obj=CTLFormulaeInput(obj)
  GenerateSystem(obj)
  obj=NTSAbstraction(NHS1)

end
end
   