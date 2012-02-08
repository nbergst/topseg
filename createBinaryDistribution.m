function dist = createBinaryDistribution( file, nLabels )

data = importdata(file);

dist = data.data;

dist = reshape(dist, nLabels,nLabels, size(data,1)/nLabels);


end