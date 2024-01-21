function SamplesnPartitionsPlot(obj,xsn)
 xsnu=samplesnoinput(obj.Initialize,xsn)';
for i =1:size(xsn,2)
    xsnpc(:,i)=obj.Initialize.coeff'*(xsnu(:,i)-obj.Initialize.mu');
end
if(size(xsnpc,1)==2)
    figure;
    plot(xsnpc(1,:),xsnpc(2,:),'.r')       
    hold on 
    partitions.intervalplot(obj.P.intervals,'empty','black')
else
    figure;
    for i=1:size(xsnpc,1)
        subplot(size(xsnpc,1),1,i)
        plot(1:size(t,2),t(i,:))
    end
end
end
