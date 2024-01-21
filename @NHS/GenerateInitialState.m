function InitialState=GenerateInitialState(obj)
      Ini_Num=obj.Initialize.verificationnum;
      Interval=initialbound;
      RandomStateInput = intervalCompute.randomPoint(Interval,Ini_Num);
      k=1;
      for i = 1:Ini_Num
          RandomStateInput = mapminmax('apply', RandomStateInput(:,i),obj.Initialize.input_ps);
          for j = 1:size(obj.P.intervals,2)
                  if(obj.P.ifin(obj.Initialize.coeff(:,1:obj.Initialize.idx)'*(RandomStateInput-obj.Initialize.mu'),obj.P.intervals{k},obj.Initialize.maximum_dimension)==1)
                      InitialState{k}=RandomStateInput;
                      k=k+1;
                  end
          end
      end
end
  