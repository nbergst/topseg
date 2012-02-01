% edgePot = createEdgePot( nodeList, edgeAttributes )
% Creates a matrix of edge potentials
% Input:
%       nEdges - Number of edges in the graph
%       edgePotentials - LxL matrix of edge potentials
% Output:
%       edgePot - Matrix of edge potentials

function edgePot = createEdgePot( nEdges, edgePotentials )

edgePot = repmat(edgePotentials, [1 1 nEdges]);

end