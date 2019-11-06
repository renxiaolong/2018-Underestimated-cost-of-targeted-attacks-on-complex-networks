clc;clear;
load('gcc_polBlogs.mat'); 

% filter giant connected component
A = sparse(A); % adjacency matrix
% [ A ] = get_GCC( A );
% E = sum(sum(A))/2;  % the number of edges

% KERNEL - GRAPH PCA
% v = sum(full(A),2); %sum of rows
% D = diag(v); 
% L = D - A;
% Lplus = pinv(L); % Pseudoinverse of L

[phase_diagram_NCUT, p_array_NCUT, Ncut_order] = equal_parititioning_ncut( A );

figure;
X = ceil(linspace(1,size(p_array_NCUT,2),50));
p = plot( p_array_NCUT(X(:)), phase_diagram_NCUT(X(:)));
set(p,'Color', [ 252/255 79/255 48/255])
