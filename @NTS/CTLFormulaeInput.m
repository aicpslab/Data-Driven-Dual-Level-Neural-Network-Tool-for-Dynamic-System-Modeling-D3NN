function obj=CTLFormulaeInput(obj)
%% User CTL formulae input
obj.Name=input('\nHow would you like to name this model abstraction?\n','s');

obj.InitialCell=input('\nSet Initial Cell: \n(should be given in the form of (x-1), \n eg., 0 for cell 1)\n','s');

CTLformulae = {'Cells should be given in form of P1.id(x-1), eg.','   A[]: Always, A[] P1.id1, always in cell 2, when given initial condition','   E<>: Eventually, E<> (P1.id3 or P1.id6) denotes there should exist at least one path, such that there is one time step in cell 4 or cell 7','   A<>: For all paths, Eventually ','   E[]: Exists, Always, E[] P1.id1 means at leat exist one trace such that its always in cell 2','   leadsto: leads to A[] (P1.id0 leadsto P1.id3) denotes for all trace cell 1 leadsto cell 4 always true.'};


fprintf('\nCTL Syntax:\n')
for i=1:size(CTLformulae,2)
         fprintf(CTLformulae{i})
          fprintf('\n')
end
n = input('\nPlease type in how many CTL formulae you want to verify: \n');
    
CTLformulae=cell(1,n);
for i=1:n
    fprintf('\n\n')
    CTLformulae{i} = input(['Please type in formula ',num2str(i),': \n'],'s');
end
obj.InputCTLformulae=CTLformulae;
end