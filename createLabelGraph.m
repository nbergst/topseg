function graph = createLabelGraph( labels )

adj = zeros(numel(labels));
graph.adj = adj;
graph.labels = labels;
graph.types = 1:numel(labels);

end