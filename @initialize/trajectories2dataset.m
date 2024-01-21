function dataset=trajectories2dataset(Trajectories)
TrajNum=size(Trajectories,2);
    Begin=1;
    for i=1:TrajNum
        End=size(Trajectories{i},2)-1+Begin;
        dataset(:,Begin:End)=Trajectories{i};
        Begin=End+1;
    end
end