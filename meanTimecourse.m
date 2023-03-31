function [squeezedTimecourse,stdTimecourse]= meanTimecourse(data,cfg)
% meanTimecourse - creates a block mean response
%  
% data is 4d matrix of volumes over time
% cfg is configuration
% Francesco D'Antonio 2023-03-23 for DAFNI class

% Translate from fsl coordinates to MATLAB ones
x = cfg.X + 1 ;
y = cfg.Y + 1 ;
z = cfg.Z + 1 ;


timeSeries = 1:1.5:48 ;

% Get the timecourse data for the voxel
meanTimecourse = mean(squeeze(data(x,y,z,:))) ;
dataTime = squeeze(data(x,y,z,:)) ;
Timecourse = (dataTime - meanTimecourse)*100./meanTimecourse;

windowTimecourse = zeros(5,32) ;
for i = 1:5
    min = 1+32*(i-1) ;
    max = 32*i ;
    windowTimecourse(i,:) = Timecourse(min:max) ;
end

squeezedTimecourse = mean(windowTimecourse,1) ;
stdTimecourse = std(windowTimecourse,1) ;
minStd = squeezedTimecourse - stdTimecourse ;
maxStd = squeezedTimecourse + stdTimecourse ;

if cfg.temporalSmoothing == 1
    squeezedTimecourse = temporalSmoothing(squeezedTimecourse) ;
    minStd = temporalSmoothing(minStd) ;
    maxStd = temporalSmoothing(maxStd) ;
    timeSeries  = temporalSmoothing(timeSeries);
    timeSeries(1) =  0;
    timeSeries(end) = 48;
    stdTimecourse = temporalSmoothing(stdTimecourse);
end

fillStd = [minStd,flip(maxStd,2)] ;
timeSeriesRev = [timeSeries,flip(timeSeries,2)];
% Plot the timecourse
plot(timeSeries,squeezedTimecourse,"Color",cfg.colour,'linewidth',1.5) 
xlabel('Time (s)'); 
ylabel('BOLD signal (% change)')
xlim([0 48])
xline(0:12:48,'--b'); 
xline(24);
ylim([-2.1 3]);
xticks(0:12:48) ;
hold on
fill(timeSeriesRev,fillStd,cfg.colour,"FaceAlpha",0.2,"EdgeColor","none");
end

