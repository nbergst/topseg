
function [ids dists] = createUnaryDistribution(file)

    
fid = fopen(file,'r');

cntr = 1;
while 1
    tline = fgetl(fid);
    if ~ischar(tline)
        break;
    end
    
    [id dist] = splitString(tline);
     
    ids{cntr} = id;
    dists(:,cntr) = dist;
    cntr = cntr+1;
end

fclose(fid);

end



% Splits the string at the space character
function [id vals] = splitString(s)

    delimiteridx = find(s == ',');
    
    ptr = 1;
    for i=1:numel(delimiteridx)
        ss{i} = s(ptr:delimiteridx(i)-1);
        ptr = delimiteridx(i)+1;
    end
    ss{i+1} = s(ptr:end);
    
    id = ss{1};
    vals = zeros(1,numel(ss)-2);
    for i=2:numel(ss)-1
        vals(i-1) = str2double(ss{i});
    end
    
end