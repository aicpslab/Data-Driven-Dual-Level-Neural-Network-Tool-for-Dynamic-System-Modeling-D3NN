function obj=ReduceSelfloop(obj)
    IntersectSet=obj.TransitionMap;
    for i= 1:size(IntersectSet,1)
       if IntersectSet(i,i)==1
          IntersectSet(i,i)=selfless(obj.NHS.Initialize,obj.demostrate,obj.NHS.P.intervals{i});
       end
    end
    obj.ReducedTransitionMap=IntersectSet;
    ModelGraph=digraph(IntersectSet);
    figure
    plot(ModelGraph,'r')
    title(['Transition Map After Reduced Selfloop with Num =',num2str(obj.NHS.Initialize.selfloopnum)])
end