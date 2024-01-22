function GenerateSystem(obj)
if(isempty(obj.ReducedTransitionMap))
IntersectSet=obj.TransitionMap;
else
IntersectSet=obj.ReducedTransitionMap;
end
intervals=obj.P.intervals;
timetic=3;
%3.1 Generating Abstraction Graph
    Num=ceil(sqrt(size(IntersectSet,1)));
% 3.1.1 Compute Each position in Graph
    relativeRate=2400/size(IntersectSet,1);
    k=1;
    for i = 1:Num
        for j =1:Num
            Location{k}=strcat(['x="',num2str(i*relativeRate+5)],['" y="',num2str(j*relativeRate+5),'"']);
            point{k}{1}=[num2str(i*relativeRate+5)];
            point{k}{2}=[num2str(j*relativeRate+5)];
            k=k+1;
        end
    end

for i = 1:size(IntersectSet,1)
    b=strcat(['location id= id',num2str(i-1)],[' ',Location{i}]);
    LocationInfo{i}= replace(b,"''",'"');
    points{i}=point{i};
    nodename{i}=strcat('[',num2str(intervals{i}(1,1)),',',num2str(intervals{i}(1,2)),']');
end


import matlab.io.xml.dom.*
docNode = Document("nta");
docRootNode = getDocumentElement(docNode);


declartion = createElement(docNode,"declaration");
appendChild(declartion,createTextNode(docNode,sprintf('// Place global declarations here.\nclock x;')));

templateElement = createElement(docNode,"template");
name = createElement(docNode,"name");
name.setAttribute('x','5');
name.setAttribute('y','5');
appendChild(name,createTextNode(docNode,"Template"));
appendChild(templateElement,name);
%appendChild(declartion,'');
for i=1:size(IntersectSet,1)
    location = createElement(docNode,'location');
    location.setAttribute('id',strcat(['id',num2str(i-1)]));
    location.setAttribute('x',points{i}{1});
    location.setAttribute('y',points{i}{2});
    name = createElement(docNode,'name');
    name.setAttribute('x',num2str(str2num(points{i}{1})+17));
    name.setAttribute('y',num2str(str2num(points{i}{2})-25));
    appendChild(name,createTextNode(docNode,strcat(['id',num2str(i-1)])));
    
    label = createElement(docNode,'label');
    label.setAttribute('kind',"invariant");
    label.setAttribute('x',num2str(str2num(points{i}{1})+1));
    label.setAttribute('y',num2str(str2num(points{i}{2})+15));
    appendChild(label,createTextNode(docNode,strcat(['x<=',num2str(timetic)])));
    
    appendChild(location,name);
    appendChild(location,label);
    % if (i==1)
    %initial = createElement(docNode,'Initial');
    %appendChild(location,initial);
    %end
    appendChild(templateElement,location);
end
initial = createElement(docNode,'init');
initial.setAttribute('ref',['id',obj.InitialCell]);
appendChild(templateElement,initial);

% Generate Transition based on State Labels
for i =1:size(IntersectSet,1)
    for j = 1:size(IntersectSet,2)
    if (IntersectSet(i,j)==1)
    transition = createElement(docNode,'transition');
     source=createElement(docNode,'source');
     source.setAttribute('ref',strcat(['id',num2str(i-1)]));
     target=createElement(docNode,'target');
     target.setAttribute('ref',strcat(['id',num2str(j-1)]));
     label = createElement(docNode,'label');
     label.setAttribute('kind',"assignment");
     appendChild(label,createTextNode(docNode,"x:=0"));
     appendChild(transition,source);
     appendChild(transition,target);
     appendChild(transition,label);
     appendChild(templateElement,transition);
    end
    end
end
appendChild(docRootNode,declartion);
appendChild(docRootNode,templateElement);

system = createElement(docNode,"system");
appendChild(system,createTextNode(docNode,sprintf('// Place template instantiations here.\nP1 = Template();  \n// List one or more processes to be composed into a system.\nsystem P1;')));
appendChild(docRootNode,system);

queries = createElement(docNode,"queries");

%% Input CTL Formulae
for i = 1:size(obj.InputCTLformulae,2)
    query{i} = createElement(docNode,"query");
    formula{i}=createElement(docNode,"formula");
    appendChild(formula{i},createTextNode(docNode,string(obj.InputCTLformulae{i})));
    appendChild(query{i},formula{i});
    appendChild(queries,query{i});
end
%%
appendChild(docRootNode,queries);

xmlFileName = [obj.Name,'.xml'];
writer = matlab.io.xml.dom.DOMWriter;
writer.Configuration.FormatPrettyPrint = true;
writeToFile(writer,docNode,xmlFileName);

end