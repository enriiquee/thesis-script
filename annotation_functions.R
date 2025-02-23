# R/annotation_functions.R
# Gene annotation functions using the pd.hta.2.0 package

library(Biobase)
library(pd.hta.2.0)
library(affycoretools)

annotation <- function(expression_data) {
  med <- new("ExpressionSet", exprs = as.matrix(expression_data))
  main <- getMainProbes("pd.hta.2.0")
  main <- main[!is.na(main$type) & main$type == 1, ]
  eset <- annotateEset(med, pd.hta.2.0)
  eset <- eset[main$transcript_cluster_id, ]
  
  # Load additional annotation information
  load(system.file("extdata/netaffxTranscript.rda", package = "pd.hta.2.0"))
  annot <- pData(netaffxTranscript)
  annot <- annot[!is.na(annot$seqname) & annot$seqname != "", ]
  annot <- annot[featureNames(eset), ]
  
  fdat <- fData(eset)
  fdat$seqname <- annot$seqname
  fdat$strand <- annot$strname  # use the appropriate column if available
  fdat$start <- annot$start
  fdat$stop <- annot$stop
  fdat$LOCUSTYPE <- annot$locustype
  fdat$category <- annot$category
  
  fData(eset) <- fdat
  return(eset)
}
