function dist = createBinaryDistribution( file, nLabels )

data = importfile(file);

dist = data.data;

dist = reshape(dist, nLabels,nLabels, size(data,1)/nLabels);


end