clear; clc; 

t = [
    "FS01", "FS02", "FS03", "FS04", "FS05",...
    "FS06", "FS07", "FS08", "FS09", "FS10", ...
    "FS11", "FS12", "FS13", "FS14", "FS15",...
    "FS16", "FS17", "FS18", "FS19",  "FS20", ...
    "FS21", "FS22", "FS23", "FS24", "FS25",...
    "FS26", "FS27", "FS28", "FS29", "FS30", ...
    "FS31", "FS32", "FS33", "FS34"...
    ];

for i =1:1
    target = t(i);
    destination = join([pwd, "/Analysis/Model/",target,".mat"],"");
    load(destination)
    a = C01_T1_Forearm(:,3); 
    b = mean(a); 
    c = linspace(b,b,length(a));
    plot(a, 'b'); 
    hold on 
    plot(c, 'r')

    
end
