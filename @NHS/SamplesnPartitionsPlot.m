function SamplesnPartitionsPlot(obj,xsn)
 xsnu=samplesnoinput(obj.Initialize,xsn)';
for i =1:size(xsn,2)
    xsnpc(:,i)=obj.Initialize.coeff'*(xsnu(:,i)-obj.Initialize.mu');
end
if(size(xsnpc,1)==2)
    figure;
        partitions.intervalplot(obj.P.intervals,'empty','black')
    hold on 
    plot(xsnpc(1,:),xsnpc(2,:))
else
    figure;
    for i=1:size(xsnpc,1)
        subplot(size(xsnpc,1),1,i)
        plot(1:size(,2),t(i,:))
    end
end
end
