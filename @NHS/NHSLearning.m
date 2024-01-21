function obj=NHSLearning(xsn,tn,Ini)
obj=NHS(xsn,tn,Ini);
SamplesnPartitionsPlot(NHS1,xsn)
PoltDataPartition(NHS1)
PredictionPlot(NHS1,xsn,tn)
Runsimulation(NHS1); 
end