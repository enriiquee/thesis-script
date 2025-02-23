
# Multi-Comparison Transcriptome Analysis Pipeline

This repository implements a comprehensive analysis pipeline for transcriptome studies. The workflow is designed to handle multiple comparisons (e.g., Progression vs. Baseline, 12W vs. Baseline, etc.) from a single R Markdown document. The pipeline covers data import and quality control, PCA and MDS visualization, hierarchical clustering, gene annotation, differential expression analysis, volcano plot visualization, heatmap generation, Gene Set Enrichment Analysis (GSEA), and preparation of data for CIBERSORTx.

## Repository Structure

```plaintext
ProjectRoot/
├── README.md                         # This file
├── .gitignore                        # Git ignore file for R, temporary files, etc.
├── analysis_script.Rmd          # Main R Markdown file for multi-comparison analysis
├── R/
│   ├── setup_packages.R              # Script to install and load required packages
│   ├── pca_functions.R               # Functions for PCA and MDS analysis
│   ├── clustering_functions.R        # Functions for hierarchical clustering and dendrogram plotting
│   ├── annotation_functions.R        # Functions for gene annotation using the pd.hta.2.0 package
│   ├── heatmap_functions.R           # Function to generate heatmaps for differentially expressed genes
│   ├── gsea_functions.R              # Functions for running Gene Set Enrichment Analysis (GSEA)
│   └── cibersort_functions.R         # (Optional) Functions for preparing data for CIBERSORTx analysis
└── Final_results_Trento/              # Folder for all generated output files (tables, plots, etc.)
```

## Getting Started

### Prerequisites

- **R (>= 4.0.0 recommended):** An up-to-date version of R is required.
- **RStudio (optional):** Recommended for an integrated development environment.
- **Required R Packages:** The pipeline relies on several CRAN and Bioconductor packages. The script `R/setup_packages.R` automatically checks for and installs any missing packages.

## Running the Analysis

1. **Data Preparation:**

   - Ensure that your input expression files are in the correct locations.
   - The analysis script automatically detects your operating system and sets the file paths accordingly. You may need to adjust these paths in the R Markdown file (`analysis_script.Rmd`) to match your directory structure.

2. **Execute the R Markdown Document:**

   Open `analysis_script.Rmd` in RStudio and click the **Knit** button to generate an HTML report that details the analysis for each comparison. The document uses a parameter vector (in the YAML header) to loop over multiple comparisons.

3. **Output Files:**

   The results (e.g., differential expression tables, volcano plots, heatmaps, GSEA results, and CIBERSORTx data) are saved in the `Final_results/` directory. Review this folder for your analysis outputs.

## File Descriptions

- **`analysis_script.Rmd`**:  
  The main R Markdown document that integrates all analysis steps. This file is parameterized to run multiple comparisons from one report.

- **`R/setup_packages.R`**:  
  Checks for and installs all required CRAN and Bioconductor packages.

- **`R/pca_functions.R`**:  
  Contains functions to perform PCA and MDS analysis and to generate corresponding plots.

- **`R/clustering_functions.R`**:  
  Provides functions for hierarchical clustering and dendrogram plotting.

- **`R/annotation_functions.R`**:  
  Contains functions for annotating genes using the `pd.hta.2.0` package (with extended annotation information).

- **`R/heatmap_functions.R`**:  
  Generates heatmaps from differentially expressed gene (DEG) data.

- **`R/gsea_functions.R`**:  
  Contains functions to perform Gene Set Enrichment Analysis (GSEA) and to generate related plots.

- **`R/cibersort_functions.R`** (optional):  
  Prepares and exports data formatted for downstream CIBERSORTx analysis.

## Customization

- **Comparisons:**  
  Modify the parameter vector in the YAML header of `analysis_script.Rmd` to select which comparisons to run. For example:
  
  ```yaml
  params:
    comparisons: ["PvsB_Paired", "12WvsB_Paired", "Pvs12W_Paired", "BvsC_Italy", "BvsC_Premiere", "BvsC_Mix", "PvsB_Italy", "PvsB_Italy_Paired"]
  ```

- **File Paths & Group Definitions:**  
  Adjust the file paths and group/factor definitions in the if–else blocks of the R Markdown document to match your experimental design and file locations.

## Contributing

Contributions are welcome! Please fork the repository and submit pull requests. For major changes, please open an issue first to discuss your ideas.

## License

This project is licensed under the MIT License – see the [LICENSE](LICENSE) file for details.

## Contact

For questions or further discussion, please contact Enrique at [enrique.perez2@um.es](mailto:enrique.perez2@um.es).


