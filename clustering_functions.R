# R/clustering_functions.R
# Functions for clustering and dendrogram plotting

library(ggdendro)
library(ggplot2)
library(cowplot)
library(gridExtra)
library(grid)
library(RColorBrewer)

# Get fill colors based on group labels
get_fill_values <- function(factors) {
  my_colors <- brewer.pal(8, "Set1")
  my_colors2 <- brewer.pal(8, "Paired")
  my_colors3 <- brewer.pal(8, "Set3")
  if (setequal(factors, c('Pre-treatment', 'Progression'))) {
    return(c(my_colors2[3], my_colors[1]))
  } else if (setequal(factors, c('Pre-Treatment', '12W'))) {
    return(c(my_colors2[3], my_colors3[5]))
  } else if (setequal(factors, c('Progression', '12W'))) {
    return(c(my_colors3[5], my_colors[1]))
  } else if (setequal(factors, c('Control', 'Pre-Treatment'))) {
    return(c(my_colors[1], my_colors2[3]))
  } else {
    return(brewer.pal(n = length(factors), name = "Set1"))
  }
}

# Hierarchical clustering function with dendrogram plot
her_clust <- function(expr.data, method, title, factors, plot = TRUE, add_legend = TRUE) {
  cor_d <- cor(expr.data, method = "pearson")
  dist_d <- as.dist(1 - cor_d)
  clust <- hclust(dist_d, method = method)
  
  # (For clarity, we assign group labels from the input factors)
  df <- data.frame(Sample = names(clust$order), 
                   Type = as.factor(factors[seq_along(clust$order)]),
                   seq = 1:length(clust$order))
  rownames(df) <- df$Sample
  
  p1 <- ggdendrogram(clust) +
    theme_void() +
    scale_x_discrete(expand = c(0.005, 0)) +
    theme(plot.margin = unit(c(0, 0, -0.5, 0), "cm"))
  
  p2 <- ggplot(df, aes(x = Sample, y = 1, fill = Type)) +
    geom_tile(color = "black", size = 0.1) +
    scale_y_continuous(expand = c(0, 0)) +
    theme(axis.title = element_blank(),
          axis.ticks = element_blank(),
          axis.text.y = element_blank(),
          axis.text.x = element_blank(),
          legend.position = "none",
          plot.margin = unit(c(-0.25, 0, 0, 0), "cm")) +
    scale_x_discrete(limits = df$Sample) +
    labs(fill = "Groups") +
    scale_fill_manual(values = get_fill_values(factors))
  
  combined <- grid.arrange(p1, p2, ncol = 1, heights = c(9/10, 1/10))
  
  if (plot) print(combined)
  return(list(clust = clust, plot = combined))
}
