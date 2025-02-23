# R/gsea_functions.R
# GSEA analysis function using clusterProfiler and enrichplot

library(clusterProfiler)
library(org.Hs.eg.db)
library(enrichplot)
library(dplyr)
library(stringr)

GSEA_Analysis <- function(dge_df, ontology = "BP") {
  # Map gene symbols to Entrez IDs
  dge_df$EntrezID <- mapIds(org.Hs.eg.db,
                            keys = dge_df$SYMBOL,
                            keytype = "SYMBOL",
                            column = "ENTREZID",
                            multiVals = "first")
  dge_df <- dge_df %>% filter(!is.na(EntrezID))
  filtered_dge <- dge_df %>% arrange(desc(abs(t))) %>% distinct(EntrezID, .keep_all = TRUE)
  
  # Create a ranked vector based on logFC
  t_vector <- filtered_dge$logFC
  names(t_vector) <- filtered_dge$EntrezID
  t_vector <- sort(t_vector, decreasing = TRUE)
  
  gse <- gseGO(geneList = t_vector,
               OrgDb = org.Hs.eg.db,
               ont = ontology,
               seed = 1234,
               minGSSize = 10,
               maxGSSize = 500,
               keyType = "ENTREZID",
               pvalueCutoff = 0.05,
               pAdjustMethod = "BH")
  
  gsea_result_df <- as.data.frame(gse@result)
  top_10 <- gsea_result_df %>% filter(p.adjust < 0.05) %>% arrange(p.adjust) %>% slice(1:10)
  NES_pos <- gsea_result_df %>% slice_max(n = 3, order_by = NES)
  NES_neg <- gsea_result_df %>% slice_min(n = 3, order_by = NES)
  
  p1 <- gseaplot2(gse, geneSetID = NES_pos$ID[1:3], subplots = 1:2, title = "Most positive NES Plot")
  p2 <- gseaplot2(gse, geneSetID = NES_neg$ID[1:3], subplots = 1:2, title = "Most negative NES Plot")
  GSEA_dotplot <- dotplot(gse, showCategory = 10, split = ".sign", x = "NES", font.size = 12) +
    scale_y_discrete(labels = function(x) str_wrap(x, width = 70)) +
    facet_grid(. ~ .sign)
  
  return(list(gsea_result = gse,
              top_10_enrichment = top_10,
              NES_Pos = NES_pos,
              NES_neg = NES_neg,
              plot = p1,
              plot2 = p2,
              GSEA_Dotplot = GSEA_dotplot))
}
