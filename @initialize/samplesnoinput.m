function xsnu=samplesnoinput(obj,xsn)
xs=xsn';
    if (size(xs,2)~=obj.systemstatedimension*obj.systemorder)
            xsnu=xs(:,1:obj.systemstatedimension*obj.systemorder);
    else
            xsnu=xs;
    end
end