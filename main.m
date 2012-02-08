function [edgeStruct nodePot edgePot] = main( id )

graphfile = sprintf('~/local/matlab/floorplan_%05d.txt',id);
attrfile = sprintf('~/local/matlab/floorplan_attributes_%05d.txt',id);
areafile = '~/local/matlab/areadist.txt';
connfile = '~/local/matlab/degreedist.txt';

nStates = 10;

% Creates graph structure
[edgeStruct nodeList] = createTopGraph( graphfile, nStates );

% Reads observations for the nodes
nodes = readAttributes( attrfile, nodeList );
for i=1:numel(nodes)
    edgeStruct.labels{i} = nodes{i}.class;
end

% Creates unary distributions for different attributes
[ids areadist] = createUnaryDistribution( areafile );
%conndist = createUnaryDistribution( connfile );

% Merges unary distributions in one matrix
udists(:,:,1) = areadist;
%udists(:,:,2) = conndist;
edgeStruct.classes = ids;

% Creates node potentials given observations and unary distributions
nodePot = createNodePot( nodeList, nodes, udists, nStates );
nodePot = nodePot + 0.1;

% Creates binary distribution (now creates uniform distribution)
edgePot = createEdgePot( edgeStruct.nEdges, nStates );


%maxOfMarginalsTRBPdecode = UGM_Decode_MaxOfMarginals(nodePot,edgePot,edgeStruct,@UGM_Infer_TRBP);

end