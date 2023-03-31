function makeMontage(data,cfg)
% makeMontage - Make a montage of images
%
%  Use a 3d array to form a montage of images
% 
% see also: montage, slice, imagesc
%   data:               3D array of brain 
%   cfg.sliceNumber:    Number of slices in montage
%   cfg.size:           Size of the montage
%   
% Francesco D'Antonio 2023-03-23 for DAFNI class

data = permute(conj(data),[2,1,3]) ;
data = flip(data,1) ;

robustRange = [0 max(data(:)/3.2)] ;

nSlices = size(data,3) ; %256
minSlice = round(nSlices*0.5) ;
maxSlice = round(nSlices*0.85) ;

if isempty(cfg.size) == 1
    cfg.size = nSlices ;
end

if isempty(cfg.sliceNumber) == 1
    cfg.sliceNumber = [1 nSlices] ;
end

slicesToDisplay = round(linspace(minSlice,maxSlice,cfg.sliceNumber)) ;


montage(data,'Indices',slicesToDisplay,'Size', cfg.size, 'DisplayRange',robustRange)
end
