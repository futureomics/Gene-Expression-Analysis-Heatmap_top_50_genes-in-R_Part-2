# Step 2: Exploratory Data Analysis (EDA)

# Heatmap of top 100 most variable genes
library(pheatmap)
top_var_genes <- order(apply(expression_data, 1, var), decreasing = TRUE)[1:50]
heatmap_data <- expression_data[top_var_genes, ]
annotation_col <- data.frame(Subtype = subtype)
rownames(annotation_col) <- colnames(expression_data)

pheatmap_plot <- pheatmap(heatmap_data,
                          annotation_col = annotation_col,
                          show_rownames = FALSE,
                          show_colnames = FALSE,
                          main = "Heatmap of Top 50 Most Variable Genes")

ggsave(file.path(image_dir, "heatmap_top_50_genes.png"))


# Hierarchical clustering
dist_matrix <- dist(t(expression_data))
hclust_result <- hclust(dist_matrix, method = "complete")
png(file = file.path(image_dir, "hierarchical_clustering_dendrogram.png"))
plot(hclust_result, labels = subtype, main = "Hierarchical Clustering Dendrogram")
dev.off()