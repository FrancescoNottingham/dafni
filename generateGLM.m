function [model,residuals] = generateGLM(ts,X)
% generateGLM - creates GLM model
%   ts = timeseries
%   X = design matrix
% Francesco D'Antonio 2023-03-23 for DAFNI class

X = [X, ones(size(X,1),1)];
beta = X\ts;
model = X*beta;
residuals = ts - model;
end