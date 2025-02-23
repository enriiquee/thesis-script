# R/setup_packages.R
# This script installs (if needed) and loads the required CRAN and Bioconductor packages

# List of CRAN packages
cran_packages <- c("ggsci", "devtools", "factoextra", "FactoMineR", "ggthemes", 
                   "ggdendro", "dplyr", "tidyverse", "cowplot", "gridtext", "grid", 
                   "ggplot2", "gridExtra", "dendextend", "GOplot", "ggnewscale", 
                   "scales", "ggpubr", "pheatmap", "gtools", "writexl", "RColorBrewer",
                   "EnhancedVolcano")

ipak <- function(pkg) {
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}
ipak(cran_packages)

# List of Bioconductor packages
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
bioc_packages <- c("Biobase", "pd.hta.2.0", "affycoretools", "tools", "affxparser",
                   "affy", "oligo", "genefilter", "limma", "clusterProfiler",
                   "org.Hs.eg.db", "enrichplot", "RegParallel", "annotate")
ipak(bioc_packages)
