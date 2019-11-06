function [Z] = Ncut_fun(A,k)

%--------------------------------------------------------------------------------------------
% Traditional NCut algorithm: Calculate graph weights from data, calculate graph Laplacian
% L = D - A, calculate Lsym = D^(-0.5)LD^(-0.5), find eigenvectors for
% Lsym, return (normalized) cluster indicator matrix Z.
%
% INPUT
%   A           : is the adjacency matrix
%   k           : is the number of clusters
% -------------------------------------------------------------------------------------------

%degree matrix
v = sum(A,2); %sum of rows
D = diag(v); 

%Laplacian matrix
L = D - A;
Lsym = D^(-1/2)*L*D^(-1/2);

%eigenvectors
%[Z,D] = eigs(Lsym, k); %cluster indicator matrix 
% 使用eigs一定要注意，特征值默认由大到小排列
% 而eig特征值默认由小到大排列

[Z,~] = eig(Lsym); % Z: eigenvector , the second parameter is eigenvalue

Z = Z(:, 1:k);

%normalize eigenvectors
 Z = Z./ repmat(sqrt(sum(Z.^2,2)), 1, size(Z,2)); %L2 norm of each row is 1


