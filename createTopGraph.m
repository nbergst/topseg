% [adj nodeList] = createTopGraph(file);
% Creates an NxN array indicating the connections in a graph
% Input:
%     file - Filename to file containing connections to a graph
%     nStates - The number of possible states existing in the graph
% Outputs:
%     edgeStruct - A structure used by UGM-lib containing the graph
%     structure
%     nodeList - N cell of node names
function [edgeStruct nodeList] = createTopGraph( file, nStates )

% Create node list
nodeList = {};

fid = fopen(file,'r');

edgeEnds = [];
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    [s1 s2] = splitString(tline);
    
    % Finds the id for each string
    [i1 i2 nodeList] = getID(s1, s2, nodeList);
    
    edgeEnds = [edgeEnds;i1 i2];
    
end

adj = zeros(numel(nodeList));
for i=1:size(edgeEnds,1)
    adj(edgeEnds(i,1), edgeEnds(i,2)) = 1;
    adj(edgeEnds(i,2), edgeEnds(i,1)) = 1;
end

fclose(fid);

edgeStruct = UGM_makeEdgeStruct(adj,nStates,1,500);

edgeStruct.adj = adj;
edgeStruct.nodeIDs = nodeList;

end


% Splits the string at the space character
function [s1 s2] = splitString(s)

    i = find(s == ' ');
    
    s1 = s(1:i-1);
    s2 = s(i+1:end);
    
end


% Takes two strings and find unique id:s
function [i1 i2 nodeList] = getID(s1, s2, nodeList)

    i1 = find(strcmp(nodeList,s1) == 1);
    if isempty(i1)
        i1 = numel(nodeList)+1;
        nodeList{i1} = s1;
    end
    
    i2 = find(strcmp(nodeList,s2) == 1);
    if isempty(i2)
        i2 = numel(nodeList)+1;
        nodeList{i2} = s2;
    end

end