function [coeff1,mu] = samplespca(obj,xsnu)
Mode=obj.mode;
[coeff,scoreeeTrain,~,~,explained,mu] = pca(xsnu);
switch Mode
    case'Select Dimension'
    %idx=find(cumsum(explained)>90,1);  % Percentage-wise Select   
    idx=obj.maximum_dimension;              % Dimensional-wise Select
    case'Percentage Contribution'
    idx=find(cumsum(explained)>90,1);  % Percentage-wise Select 
end
coeff1=coeff(:,1:idx);
end