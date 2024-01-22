function   obj=TransitionCompute(obj)
intervals=obj.P.intervals;
Maximum_Dimension=obj.NHS.Initialize.maximum_dimension;
IntersectSet= zeros(size(intervals,2));
     for i = 1: size(intervals,2)
        for j = 1: size(intervals,2)
            tic
            I=intervals{j};    
            for z=1:size(obj.NHS.P1.intervals,2)
                for l=0:Maximum_Dimension:size(obj.NHS.P1.intervals{z},1)-1
                    Lowerbound=max([intervals{j}(:,1)';obj.NHS.P1.intervals{z}(l+1:l+Maximum_Dimension,1)'])';
                    Upperbound=min([intervals{j}(:,2)';obj.NHS.P1.intervals{z}(l+1:l+Maximum_Dimension,2)'])';
                    if(min(Lowerbound<Upperbound))
                        Intersectflag = ifNextIntersect(obj.NHS.ELMs(z),intervals{i},[Lowerbound,Upperbound]);
                              if(Intersectflag)
                                IntersectSet(i,j)=1;
                              end
                    end
                end
            end
            toc
        end
     end
obj.TransitionMap=IntersectSet;
ModelGraph=digraph(IntersectSet);
figure
plot(ModelGraph,'b')
end