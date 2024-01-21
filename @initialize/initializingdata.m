function [xsn,xsnu,tn,input_ps,output_ps,coeff,mu]=initializingdata(obj,dataset)
[xs,t] = dataset2samples(obj,dataset);
[xsn,tn,input_ps,output_ps] = samplesmapminmax(obj,xs,t);
xsnu=samplesnoinput(obj,xsn);
[coeff,mu] = samplespca(obj,xsnu);

end