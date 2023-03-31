function returnTimecourse(data,cfg)
% getTimecourse - gets the time course for a single voxel
%  
% data is 4d matrix of volumes over time
% cfg is configuration
% Francesco D'Antonio 2023-03-23 for DAFNI class

% Translate from fsl coordinates to MATLAB ones
x = cfg.X + 1 ;
y = cfg.Y + 1 ;
z = cfg.Z + 1 ;

design = cfg.design ;

volumeNumber = size(data,4) ;
timeSeries = linspace(1,volumeNumber,volumeNumber).*1.5 ;

meanTimecourse = mean(squeeze(data(x,y,z,:))) ;
% Get the timecourse data for the voxel
timeCourse = (squeeze(data(x,y,z,:)) - meanTimecourse)*100./meanTimecourse;


% Plot the timecourse
plot(timeSeries,timeCourse,"Color",cfg.colour,'linewidth',1)
hold on

if cfg.performGLM == 1
    [model, residuals]  = generateGLM(timeCourse,design) ;
    plot(timeSeries,model,"Color",cfg.GLMcolour,'linewidth',1)
end

xlabel('Time (s)'); 
ylabel('BOLD signal (% change)')
xlim([0 240]) ;
xticks(0:24:240) ;
xline(0:12:240,'--b'); 
xline(0:24:240); 

if cfg.plotResiduals == 1
    plot(timeSeries,residuals,"Color",cfg.residualsColour,'linewidth',1.5) 
    xlabel('Time (s)'); 
    ylabel('Residuals (% Change)')
    xlim([0 240])
    xline(0:12:240,'--b'); 
    xline(0:24:240); 
    xticks(0:24:240) ;
end

end

