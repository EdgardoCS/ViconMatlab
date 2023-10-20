targetSubjects = ["S03", "S04"]; % here modify target subject
%{

currentFolder = pwd;

destination = [currentFolder,"\DataMatlab\",targetSubjects(2),".mat"];
targetDataset = join(destination,"");
load(targetDataset); %this folder may vary

a = Frontal_Post_ScapularTilt

%}