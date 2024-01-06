function [xs,t] = dataset2samples(obj,dataset)
    if size(dataset,2)==1
        xs=zeros((size(dataset,2)-obj.systemorder),obj.systemstatedimension*obj.systemorder+size(dataset,1)-obj.systemstatedimnsion);
        t=zeros((size(dataset,2)-systemorder),systemstatedimension);    
        Begin=1;
        End =size(dataset,2);    
                for k= 1:obj.systemstatedimension
                        t(Begin:End-obj.systemorder,k) = dataset(k,obj.systemorder+1:end);
                    for j = 1:obj.systemorder
                        xs(Begin:End-obj.systemorder,obj.systemstatedimension*(j-1)+k) = dataset(k,j:end-obj.systemorder+j-1);            
                    end
                end
                if(size(dataset,1)~=obj.systemstatedimension)
                    xs(Begin:End-obj.systemorder,obj.systemstatedimension*obj.systemorder+1:end)=dataset(obj.systemstatedimension+1:end,:)';
                end
        else
        TrajNum=size(dataset,2);
        xs=zeros((size(dataset{1},2)-obj.systemorder)*TrajNum,obj.systemstatedimension*obj.systemorder+size(dataset{1},1)-obj.systemstatedimension);
        t=zeros((size(dataset{1},2)-obj.systemorder)*TrajNum,obj.systemstatedimension);    
        for i = 1:TrajNum
            Begin=(size(dataset{i},2)-1)*(i-1)+1;
            End = (size(dataset{i},2)-1)*(i-1)+size(dataset{i},2);    
                for k= 1:obj.systemstatedimension
                        t(Begin:End-obj.systemorder,k) = dataset{i}(k,obj.systemorder+1:end);
                    for j = 1:obj.systemorder
                        xs(Begin:End-obj.systemorder,obj.systemstatedimension*(j-1)+k) = dataset{i}(k,j:end-obj.systemorder+j-1);            
                    end
                end
                if(size(dataset{i},1)~=obj.systemstatedimension)
                    xs(Begin:End-obj.systemorder,obj.systemstatedimension*obj.systemorder+1:end)=dataset{i}(obj.systemstatedimension+1:end,:)';
                end
        end
    end
end