function PredictionPlot(obj,xsn,tn)
   subfolderName = [obj.Initialize.name, 'Result'];
   subfolderPath = fullfile([pwd,'\Results'], subfolderName);
   if ~exist(subfolderPath, 'dir')
    mkdir(subfolderPath)
   end

   xsnu=samplesnoinput(obj.Initialize,xsn)';
   segmentIndex=obj.P1.intervals;
   inputspace1=obj.P1.intervals;
    for i = 1:size(tn,2)
            for k = 1:size(segmentIndex,2)
                      if(partitions.ifin(obj.Initialize.coeff'*(xsnu(:,i)-obj.Initialize.mu'),segmentIndex{k},obj.Initialize.maximum_dimension)==1)
                               output_switch(:,i)= ELMpredict(obj.ELMs(k),xsn(:,i));
                      end
            end
    end
    t= mapminmax('reverse',tn,obj.Initialize.output_ps); 
    ON_S= mapminmax('reverse',output_switch(:,1:end),obj.Initialize.output_ps); 
    if (size(tn,1)==2)
        figure;
        plot(t(1,:),t(2,:),'*')
        hold on 
        plot(ON_S(1,:),ON_S(2,:),'o')
        title([obj.Initialize.name,' Prediction Mode (2-Dimenional)']);
        filename = ['3_b ',obj.Initialize.name,' Prediction Mode (2-Dimenional)'];
        fullpath = fullfile(subfolderPath, filename);
        saveas(gcf, fullpath);
    end 
    figure;
    for i = 1:size(t,1)
            subplot(size(t,1),1,i)
            plot(1:size(t,2),t(i,:))
            hold on 
            plot(1:size(t,2),ON_S(i,:))
            xlabel('step')
            ylabel('position')
            hold on
        title([obj.Initialize.name,' Prediction Mode (NHS)']);
        filename = ['3_',obj.Initialize.name,' Prediction Mode (NHS)'];
        fullpath = fullfile(subfolderPath, filename);
        saveas(gcf, fullpath);
    end
end