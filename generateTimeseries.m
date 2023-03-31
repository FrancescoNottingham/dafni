%% Generates time-series plots
% Francesco D'Antonio 2023-03-23 for DAFNI class
% Cluster Max
% 
% A>B
% Loc       Descr
% 22 18 4   Temp Occip Fus (TOF)
% 27 16 21  Lat Occip Cor  (LOC)
%
% B>A
% Loc       Descr
% 44 16 7  Occ Fusi Gyr (OFG)
data = niftiread('sub4_FFA_filtered_func_data.nii.gz') ;
design = load('designFFA.txt') ;

cfgTOF.X = 22  ;
cfgTOF.Y = 18  ;
cfgTOF.Z = 4  ;
cfgTOF.colour = [132 186 91]./255 ;
cfgTOF.temporalSmoothing = 1  ;
cfgTOF.performGLM = 1 ;
cfgTOF.GLMcolour = [62 150 81]./255  ;
cfgTOF.design = design  ;
cfgTOF.plotResiduals = 0  ;
cfgTOF.residualsColour = [132 186 91]./255 ;


cfgLOC.X = 27  ;
cfgLOC.Y = 16  ;
cfgLOC.Z = 21  ;
cfgLOC.colour = [57 106 177]./255  ;
cfgLOC.temporalSmoothing = 1  ;
cfgLOC.performGLM = 0 ;
cfgLOC.GLMcolour = [144 103 167]./255  ;
cfgLOC.design = design  ;
cfgLOC.plotResiduals = 0  ;
cfgLOC.residualsColour = [144 103 167]./255 ;

cfgOFG.X = 44  ;
cfgOFG.Y = 16  ;
cfgOFG.Z = 7  ;
cfgOFG.colour = [204 37 41]./255  ;
cfgOFG.temporalSmoothing = 1  ;
cfgOFG.performGLM = 0 ;
cfgOFG.GLMcolour = [171 104 87]./255  ;
cfgOFG.design = design  ;
cfgOFG.plotResiduals = 0  ;
cfgOFG.residualsColour = [171 104 87]./255 ;


figure(1);
subplot(2,1,1)
returnTimecourse(data,cfgTOF) ;
hold on
cfgTOF.performGLM = 0 ;
subplot(2,1,2)
returnTimecourse(data,cfgOFG)
hold on
returnTimecourse(data,cfgTOF) ;

figure(2);
subplot(2,1,1)
meanTimecourse(data,cfgTOF) ;
hold on
meanTimecourse(data,cfgOFG) ;
subplot(2,1,2)
meanTimecourse(data,cfgLOC) ;
meanTimecourse(data,cfgTOF) ;

