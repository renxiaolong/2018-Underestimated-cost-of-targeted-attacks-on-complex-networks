function [ s ] = get_GCC_size( A )
%GET_GCC takes oroginal network A and outputs the size of GCC

%all to all shortest paths, uses https://au.mathworks.com/help/bioinfo/ref/graphallshortestpaths.html
% D = graphallshortestpaths(sparse(A)); 
% 
% % if not available, use the local function inside of folder for smaller
% % networks
% %D = allspath(A);
% 
% % how many nodes are reachable from each node
% component_sizes = sum(D<Inf);
% 
% % find index of nodes that belong to GCC
% [idx,val] = find(max(component_sizes));
% 
% % get all nodes that belong to GCC i.e. reachable from node idx
% filter_nodes = D(idx,:)<Inf;
% 
% s = sum(filter_nodes);

B = largestcomponent(A);
s = size(B,2);

end

