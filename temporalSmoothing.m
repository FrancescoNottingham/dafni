function [dataSmooth] = temporalSmoothing(dataIn)
% Temporally smooth data
% Francesco D'Antonio 2023-03-23 for DAFNI class

dataSmooth = zeros(size(dataIn)-1) ;
arraySize = numel(dataIn) ;

for i = 2:arraySize-1
    dataToMean  = [dataIn(i-1) dataIn(i) dataIn(i+1)] ;
    dataSmooth(i) = mean(dataToMean) ;
end

dataToMean  = [dataIn(2) dataIn(1) dataIn(end)] ;
dataSmooth(1) = mean(dataToMean) ;
dataToMean  = [dataIn(1) dataIn(end) dataIn(end-1)] ;
dataSmooth(end) = mean(dataToMean) ;

end
