# R/pca_functions.R
# Functions for PCA and MDS plotting

library(FactoMineR)
library(factoextra)
library(ggplot2)
library(RColorBrewer)

# Run PCA on the transposed expression data
biom_pca <- function(expr.data) {
  PCA(t(expr.data), scale.unit = TRUE, ncp = min(ncol(expr.data), 10), graph = FALSE)
}

# Plot PCA using factoextra
plot.pca1 <- function(expr.data, title, factors, legend_text_size = 12,
                      axis_title_size = 14, axis_text_size = 12) {
  pca_result <- biom_pca(expr.data)
  explained_variance <- pca_result$eig[, 2]
  
  # Define colors based on factors (customize as needed)
  my_colors <- brewer.pal(8, "Set1")
  my_colors2 <- brewer.pal(8, "Paired")
  my_colors3 <- brewer.pal(8, "Set3")
  
  if (setequal(factors, c('Pre-treatment', 'Progression'))) {
    color_vals <- c(my_colors2[3], my_colors[1])
  } else if (setequal(factors, c('Pre-Treatment', '12W'))) {
    color_vals <- c(my_colors3[5], my_colors2[3])
  } else if (setequal(factors, c('Progression', '12W'))) {
    color_vals <- c(my_colors3[5], my_colors[1])
  } else if (setequal(factors, c('Control', 'Pre-Treatment'))) {
    color_vals <- c(my_colors2[3], my_colors[1])
  } else {
    color_vals <- my_colors[seq_along(factors)]
  }
  
  p <- fviz_pca_ind(pca_result,
                    title = title,
                    legend.title = "Group",
                    legend.position = "top",
                    pointsize = 3,
                    geom = "point",
                    col.ind = as.factor(factors))
  p <- p + scale_color_manual(values = color_vals) +
    scale_shape_manual(values = c(17, 16)) +
    theme(axis.line = element_line(size = 1, colour = "black"),
          legend.text = element_text(size = legend_text_size),
          axis.title = element_text(size = axis_title_size),
          axis.text = element_text(size = axis_text_size)) +
    xlab(paste0("PCA1 (", round(explained_variance[1], 1), "%)")) +
    ylab(paste0("PCA2 (", round(explained_variance[2], 1), "%)"))
  return(p)
}
