function flag=ifNextIntersect(ffnn,input,interval)

L1 = LayerS(ffnn.weight{1,1}, ffnn.bias{1,1}, 'poslin'); 
L2 = LayerS(ffnn.weight{1,2}, ffnn.bias{1,2}, 'purelin');   
F = FFNNS([L1 L2]); % construct an NNV FFNN
lb=input(:,1);
ub=input(:,2);

I_Poly = Polyhedron('lb', lb, 'ub', ub); % polyhedron input set
[R2, ~] = F.reach(I_Poly, 'exact-polyhedron'); 

lb=interval(:,1);
ub=interval(:,2);
P_Poly = Polyhedron('lb', lb, 'ub', ub); 

flag=0;
for i=1:length(R2)
    M = R2(i).intersect(P_Poly);
    if (~M.isEmptySet)
        flag = 1;
    end
end

end