% nodePot = createNodePot( nodeList, nodeAttributes, dists )
%
% This function creates the node potentials, that is a matrix where each
% row contains a probability distribution for one node over the labels
% given the attributes for that node.
% Input:
%       nodeList - A cell structure containing all nodes in the graph
%       nodeAttributes - A matrix where each row contains the attributes
%                        for one node
%       dists - A matrix containing the distributions for each label and
%               attribute
% Output:
%       nodePot - A matrix containing probaility distributions for each
%                 node over all labels
%
function nodePot = createNodePot( nodeList, nodeAttributes, dists )

% MxN matrix where element (m,n) indicates the potential for node m
% having label n (not necessarily normalized)
nodePot = ones(numel(nodeList), size(dists,3));

% Goes through all nodes and computes observation likelihoods
for i=1:numel(nodeList)
    
    % Goes through each attribute and computes a potential given each
    % label. Assumes attributes are independent
    for l=1:size(dists,3)
        dist = dists(:,:,l);
        for a=1:size(nodeAttributes,2)
            
            nodePot(i,l) = nodePot(i,l)*getPotential(nodeAttributes(i,a),dist(:,i));
            
        end
    end
    
end


end


function p = getPotential( attribute, dist )

p = dist(attribute) / sum(dist);

end