function [ phase_diagram, p_array, Ncut_order ] = equal_parititioning_ncut( A )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
A_new = full(A);
num_removed = 0;
gcc_size_tmp = size(A,1);

phase_diagram = [];
p_array = [];
Ncut_order = zeros(size(A));

while (gcc_size_tmp > (0.01*size(A,1)))
    %find gcc
    idx = largestcomponent(A_new);
    filter_nodes = logical(zeros(size(A_new,1),1));
    filter_nodes(idx) = 1;
    A_sub = A_new(filter_nodes, filter_nodes);
    
    %subdivide gcc fracation
    [H] = Ncut_fun(A_sub,2);  % 2 is the number of clusters
    % [H] = eigenvectorPower(A_sub);
    if (sum(isnan(H)==0))
        [IDX,C] = kmeans_new2(H',2); %kmeans_new2 is free kmeans function
        %[IDX] = eigVectorPartition(H);
        IDX = IDX';
    else
        disp('Ncut NaN in H matrix!');
    end
   
   [I,J,val] = find(triu(A_new));
   for k = 1 : size(val,1)
            m = I(k);
            n = J(k);
            if ((filter_nodes(m)==1)&&(filter_nodes(n)==1) ) % edge exists and is in the A_sub
                node_sub_m_idx = find(idx == m);
                node_sub_n_idx = find(idx == n);
                if (IDX(node_sub_m_idx(1)) ~= IDX(node_sub_n_idx(1)))
                    A_new(m,n)=0;
                    A_new(n,m)=0;
                    num_removed = num_removed + 1;
                    Ncut_order(m, n) = num_removed; 
                    Ncut_order(n, m) = num_removed; 
                    disp('step: 200')
                    if (mod(num_removed,200)==0)
                        num_removed
                        gcc_size_tmp = get_GCC_size( A_new );
                    end
                    phase_diagram(num_removed) = gcc_size_tmp;
                    p_array(num_removed) = num_removed;
                end
               % && (IDX(m) ~= IDX(n))) %edge (m,n) is between cluster IDX(m) and IDX(n)
            end
    end  
end
p_array = p_array./ (sum(sum(A))/2);
phase_diagram = phase_diagram./size(A,1);
Ncut_order = sparse(Ncut_order);
end

