function IntersectSet=decreaseselfloop(obj,IntersectSet,demostrate,P1)
    for i= 1:size(IntersectSet,1)
       if IntersectSet(i,i)==1
          IntersectSet(i,i)=Selfless(obj,demostrate,P1.intervals{i});
       end
    end

end