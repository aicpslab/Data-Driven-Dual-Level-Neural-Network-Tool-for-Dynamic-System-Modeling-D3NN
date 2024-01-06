function MergeIntervalPlot(I,MaximumDimension,Num)
    if(Num~=0)
        Count= 9999/Num;
        color={};
        for i = 1:Num
            colorNum=i*Count;
            if colorNum>10000
             colorNum=colorNum-10000;
            end    
             color=[color,[mod(colorNum,1000)/1000,mod(colorNum,100)/100,mod(colorNum,10)/10]];
        end
     else
        color={0};
    end
% switch(Num)
%     case 1 
%         color={'red'};
%     case 2 
%         color={'red','green'};
%     case 3 
%         color={'red','green','blue'};
%     case 4 
%         color={'red','green','blue','cyan'};
%     case 5 
%         color={'red','green','blue','cyan','magenta'};
%     case 6 
%         color={'red','green','blue','cyan','magenta','yellow'};
%     case 7 
%         color={'red','green','blue','cyan','magenta','yellow','black'};
%     otherwise
%         color={0};
% end
if (color{1}(1)~=0)
   Numcounter=0;
    for i = 1:1:length(I)
        if (size(I{i},1)>MaximumDimension)
           Numcounter=Numcounter+1;
           for j = 0:MaximumDimension:size(I{i},1)-2
             intervalCompute.plot_single(I{i}(j+1:j+2,:),'full',color{Numcounter});
             c = num2str(i);
             text(mean(I{i}(j+1,:)),mean(I{i}(j+2,:)),c);
             hold on;
           end
        end
    end
else
    fprintf('not support merge graph ploting!')
end

end