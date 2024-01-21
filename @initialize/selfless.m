function flag=selfless(obj,demos,interval)
flag = 0;
counter=zeros(size(demos,2),1);
for i = 1:size(demos,2)
    counter(i) = 0;
    for j = 1: size(demos{1,i},2)
         if(partitions.ifin(obj.coeff'*(demos{1,i}(1:obj.systemstatedimension*obj.systemorder,j)-obj.mu'),interval,size(obj.coeff,2))==1)   
            counter(i)=counter(i)+1;
        end
    end
end


for i = 1:size(demos,2)
   if counter(i)>obj.selfloopnum
       flag=1;
   end
end

end