function data = kmeans_clus_n(data,cluster_n,i)
[~,C] = kmeans(data,cluster_n-1);
C = sort(C);
data = ExtractClass(C,i);
end
