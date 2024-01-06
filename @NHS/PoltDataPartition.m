function PoltDataPartition(obj)
NonsinglePartionCounter=0;
    for i=1:size(obj.P1.intervals,2)
        if(size(obj.P1.intervals{i},1)~=obj.Initialize.maximum_dimension)
            NonsinglePartionCounter=NonsinglePartionCounter+1;
        end
    end       
subfolderName = [obj.Initialize.name, 'Result'];
subfolderPath = fullfile([pwd,'\Results'], subfolderName);

if ~exist(subfolderPath, 'dir')
    mkdir(subfolderPath)
end

figure;
    partitions.intervalplot(obj.P.intervals,'empty','black')
hold on
    partitions.MergeIntervalPlot(obj.P1.intervals,obj.Initialize.maximum_dimension,NonsinglePartionCounter)  
title([obj.Initialize.name,' Partitions and Merge']);
filename = ['2_',obj.Initialize.name,' Partitions and Merge'];
fullpath = fullfile(subfolderPath, filename);
saveas(gcf,fullpath);
end