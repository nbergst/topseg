% nodeAttributes = readAttributes(file);
% Reads a file on format:
%       <node_id> <attr_1> <attr_2> ... <attr_N>
%       ...
% Inputs:
%       file - name of file with attributes
%       nodeVals - cell structure with node names, used for looking
%                  up index of <node_id> to be used in nodeAttributes
% Outputs:
%       nodeAttributes - a NxM array with attributes

function nodeAttributes = readAttributes(file,nodeVals)

fid = fopen(file,'r');

while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    [id vals] = splitString(tline);
    
    idx = find(strcmp(nodeVals,id) == 1);
    
    if isempty(idx)
        nodeAttributes = [];
        return;
    end
    
    nodeAttributes(idx,:) = vals;
end

fclose(fid);


end

% Splits the string at the space character
function [id vals] = splitString(s)

    delimiteridx = find(s == ' ');
    
    ptr = 1;
    for i=1:numel(delimiteridx)
        ss{i} = s(ptr:delimiteridx(i)-1);
        ptr = delimiteridx(i)+1;
    end
    ss{i+1} = s(ptr:end);
    
    id = ss{1};
    vals = zeros(1,numel(ss)-1);
    for i=2:numel(ss)
        vals(i-1) = str2double(ss{i});
    end
    
end
