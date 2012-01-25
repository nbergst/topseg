% [edgeEnds nodeList] = createTopGraph(file);
% Creates an Nx2 array of connections in a graph
% Input:
%     file - Filename to file containing connections to a graph
% Outputs:
%     edgeEnds - Nx2 array of graph connections
%     nodeList - N cell of node names
function [edgeEnds nodeList] = createTopGraph(file)

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

fclose(fid);

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