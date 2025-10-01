# DeepSeek-KT-Benchmark (R Visualization Scripts)

This repository contains R scripts and structured templates for generating benchmark figures used in evaluating LLM performance in medical knowledge tasks. These visualizations assess **accuracy**, **consistency**, **readability**, and **comprehensiveness** across different models or response sets.

## 📁 Directory Structure

```
DeepSeek-KT-Benchmark-R-visuals/
├── visualize_accuracy.R              # Bar chart of accuracy classification
├── visualize_consistency.R           # Bar chart of model consistency with doctors
├── visualize_likert_responses.R      # Stacked Likert plot for readability & comprehensiveness
├── data/                             # Place your Excel data files here
├── figures/                          # Output figures will be saved here


## 🔧 Requirements

Ensure the following R packages are installed:

```r
install.packages(c("readxl", "dplyr", "tidyr", "ggplot2", "scales"))
```

## 📊 Script Descriptions

### 1. `visualize_accuracy.R`
- Reads `data/accuracy.xlsx` (multiple sheets, each per model).
- Aggregates responses into three categories:
  - `completely incorrect`
  - `mixed`
  - `correct`
- Generates a stacked bar chart showing percentage breakdown by model.

### 2. `visualize_consistency.R`
- Reads `data/consistency.xlsx`.
- Two categories: `Consistent` and `Inconsistent`.
- Stacked bar chart shows percentage of agreement with medical recommendations.

### 3. `visualize_likert_responses.R`
- Reads two files:
  - `readability.xlsx`
  - `comprehensiveness.xlsx`
- Both contain Likert-scale ratings per question.
- Produces normalized stacked bar charts using `RdYlGn` palette.

## 🧪 Usage

After placing your Excel files in the `data/` directory, run each script in RStudio or R console:

```r
source("visualize_accuracy.R")
source("visualize_consistency.R")
source("visualize_likert_responses.R")
```

Figures will be saved to `figures/` as `.png` files.

## 🔒 Reproducibility Notice

These scripts are designed for open publication of benchmark visualization pipelines in line with reproducibility standards.

---
