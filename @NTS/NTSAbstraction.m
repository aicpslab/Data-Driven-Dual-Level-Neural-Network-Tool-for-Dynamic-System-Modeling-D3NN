function obj=NTSAbstraction(NHS1)
    obj=NTS(NHS1);
    obj=TransitionCompute(NTS1);
    obj=ReduceSelfloop(NTS1);
end