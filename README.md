# Transcriptome Analysis: Progression vs Baseline (Paired)

This repository contains an analysis pipeline for a transcriptome study comparing progression versus baseline conditions using paired samples. The workflow covers data import, quality control, PCA, clustering, gene annotation, differential expression analysis, volcano plot visualization, heatmap generation, Gene Set Enrichment Analysis (GSEA), and CIBERSORT analysis.

## Repository Structure

```plaintext
ProjectRoot/
├── README.md                     # This file
├── .gitignore                    # Git ignore file for R, temporary files, etc.
├── analysis.Rmd                  # Main R Markdown file that drives the complete analysis
├── R/
│   ├── setup_packages.R          # Script to install and load required packages
│   ├── pca_functions.R           # Functions for PCA and MDS analysis
│   ├── clustering_functions.R    # Functions for hierarchical clustering and dendrogram plotting
│   ├── annotation_functions.R    # Functions for gene annotation using the pd.hta.2.0 package
│   ├── heatmap_functions.R       # Function to generate heatmaps for differentially expressed genes
│   ├── gsea_functions.R          # Functions for running Gene Set Enrichment Analysis (GSEA)
│   └── cibersort_functions.R     # (Optional) Functions for preparing data for CIBERSORT analysis
└── Final_results/                # Folder where all generated output files (tables, plots, etc.) are saved
```
## Getting Started

### Prerequisites

- **R (>= 4.0.0 recommended)**: Ensure that you have an up-to-date version of R installed.
- **RStudio (optional)**: Recommended for an integrated development environment.
- **Required R Packages**: The analysis requires several CRAN and Bioconductor packages. The script `R/setup_packages.R` will check and install any missing packages automatically.

## Running the Analysis

1. **Data Preparation:**

   - Ensure that your input expression file is placed in the correct location.
   - The analysis script auto-detects your operating system and sets the file path accordingly. You may need to adjust the paths in the `analysis.Rmd` file.

2. **Execute the R Markdown Document:**

   Open `analysis.Rmd` in RStudio and click the **Knit** button to generate an HTML report of the analysis. This document includes all steps from data import through visualization and statistical analysis.

3. **Output Files:**

   The results (e.g., tables, plots, and exported Excel/CSV files) are saved in the `Final_results_Trento/` directory. Check this folder for outputs like differential expression tables, volcano plots, heatmaps, GSEA results, and CIBERSORT data.

## File Descriptions

- **`analysis.Rmd`**: The main analysis document that integrates all functions and scripts. It provides a clear, step-by-step report of the analysis.
- **`R/setup_packages.R`**: Checks for and installs required packages.
- **`R/pca_functions.R`**: Contains functions to perform PCA and create related plots.
- **`R/clustering_functions.R`**: Provides hierarchical clustering functions and dendrogram plotting.
- **`R/annotation_functions.R`**: Contains functions for gene annotation based on the pd.hta.2.0 package.
- **`R/heatmap_functions.R`**: Generates heatmaps from differentially expressed genes.
- **`R/gsea_functions.R`**: Functions for performing GSEA and generating associated plots.
- **`R/cibersort_functions.R`** (optional): Prepares and exports data formatted for CIBERSORT analysis.

## Contributing

Contributions are welcome! Please fork the repository and submit pull requests. For major changes, open an issue first to discuss what you would like to change.

## License

This project is licensed under the MIT License – see the LICENSE file for details.

## Contact

For questions or further discussion, please contact Enrique at [enrique.perez2@um.es](mailto:enrique.perez2@um.es).


