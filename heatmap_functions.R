# R/heatmap_functions.R
# Function to generate a heatmap of selected genes

library(pheatmap)
library(ggplot2)

heatmap_plot <- function(eset, res_results) {
  # Filter genes based on thresholds
  final_genes <- res_results[abs(res_results$logFC) >= 0.3 &
                               res_results$P.Value <= 0.01 &
                               res_results$adj.P.Val <= 0.05, ]
  
  dds <- exprs(eset)
  selected <- rownames(dds) %in% final_genes$PROBEID
  dds_filtered <- dds[selected, ]
  
  # Create a top-25 heatmap from more stringent filtering
  results_table_filt <- subset(res_results, abs(logFC) > 0.5 & adj.P.Val <= 0.01)
  UP <- results_table_filt[order(results_table_filt$logFC, decreasing = TRUE), ][1:25, ]
  DOWN <- results_table_filt[order(results_table_filt$logFC), ][1:25, ]
  Merge_UPDOWN <- rbind(UP, DOWN)
  
  sigprobes <- Merge_UPDOWN$PROBEID
  heat <- t(scale(t(exprs(eset))))
  heat2 <- heat[sigprobes, ]
  rownames(heat2) <- Merge_UPDOWN$SYMBOL
  brks <- seq(-2, 2, length.out = 100)
  
  pheatmap(heat2, scale = "row", cluster_rows = FALSE, breaks = brks)
}
