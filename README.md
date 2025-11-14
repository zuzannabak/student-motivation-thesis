# Student Learning Engagement and Future Time Perspective (FTP)

This repository contains the code, processed data, and thesis PDF for my bachelor thesis on university students' learning engagement in the context of Future Time Perspective (FTP).

> **Thesis (Polish title):**  
> _Zaangażowanie studentów do nauki w kontekście teorii FTP_  
> SGH Warsaw School of Economics – Quantitative Methods in Economics and Information Systems


## Project overview

- **Goal:** Analyse how future time perspective, personality traits, time use, financial support, and study-related characteristics are associated with students' learning engagement.
- **Sample:** 198 university students in Poland (online survey).
- **Design:** Cross-sectional study based on a questionnaire created in Microsoft Forms.
- **Outcome variable:** Index of learning engagement (constructed from several study-related behaviours), analysed in **logarithmic form** in the final model.
- **Result:** The final regression model explains about **57% of the variance** in engagement (R² ≈ 0.576).
- **Tools:** R for data processing, regression modelling, diagnostics, and visualisation.


## Methods (short)

1. **Data collection**
   - Online survey measuring:
     - learning engagement,
     - Future Time Perspective (FTP),
     - Big Five personality traits,
     - time spent on different activities,
     - financial situation and parents’ education,
     - basic demographics.

2. **Data preparation**
   - construction of scale scores,
   - coding of categorical variables (field and mode of study, place of residence, etc.),
   - transformations of key variables (e.g. log of engagement, squared IQ, squared financial support),
   - removal of clearly invalid or incomplete responses.

3. **Modelling**
   - multiple linear regression with:
     - socio-economic variables,
     - psychological characteristics (FTP, personality),
     - measures of time allocation,
   - addition of theoretically motivated interaction terms, such as:
     - FTP × time spent on non-academic activities,
     - FTP × openness to experience,
     - disposable income × mode of study.

4. **Model diagnostics**
   - multicollinearity checks (VIF / GVIF),
   - Breusch–Pagan test for heteroskedasticity,
   - Shapiro–Wilk test and QQ plots for residual normality,
   - RESET test for functional form and specification.

The final model explains around 57% of the variance in students’ engagement (R² ≈ 0.576).


## Repository structure

This is the current layout of the repository:

```text
.
├── data/
│   └── danedoanalizy_doR.txt            # processed dataset used in the final models
├── docs/
│   └── thesis_Zuzanna_Bak_2024.pdf      # final thesis (PDF, in Polish)
├── figures/
│   ├── interaction_plots.pdf            # interaction effects used in the thesis
│   ├── qq_plot.png                      # QQ plot of residuals
│   └── residuals_plot.png               # residuals vs fitted (or similar diagnostic plot)
├── R/
│   ├── 01_data_preparation_and_base_model.R
│   └── 02_interaction_model_and_model_selection.R
└── README.md
```

- The **R scripts** reproduce the main analyses reported in the thesis.
- The **data file** is the processed dataset used in the final models.
- The **PDF** in `docs/` is the full text of the thesis.


## How to reproduce the analysis

1. Clone the repository:

   ```bash
   git clone https://github.com/zuzannabak/student-motivation-thesis.git
   cd student-motivation-thesis
   ```

2. Open R or RStudio and set the working directory to the root of the repository.

3. Install the required R packages (if needed). For example:

   ```r
   install.packages(c("car", "lmtest"))
   ```

   (Plus any additional packages mentioned at the top of the scripts.)

4. Run the scripts in order:

   ```r
   source("R/01_data_preparation_and_base_model.R")
   source("R/02_interaction_model_and_model_selection.R")
   ```

5. The scripts will:

   - load `data/danedoanalizy_doR.txt`,
   - construct the variables used in the thesis,
   - estimate the baseline and extended models with interactions,
   - print regression summaries,
   - generate diagnostic plots and interaction plots (saved in `figures/`).


## Data and privacy

- The dataset in `data/` is a **processed** version used directly in the empirical analysis.
- The original raw questionnaire file with individual responses is **not** included in this repository.
- The dataset does **not** contain direct personal identifiers, but it should still be treated as research data.  
  Please do not attempt to re-identify participants or link records to specific individuals.

If you are interested in the questionnaire or in using a similar dataset, please contact me directly.


## Thesis

The full thesis (in Polish) is available at:

- `docs/thesis_Zuzanna_Bak_2024.pdf`

If you refer to this work, you can cite for example:

> Bąk, Z. (2024). *Zaangażowanie studentów do nauki w kontekście teorii FTP.*  
> Bachelor thesis, SGH Warsaw School of Economics, Warsaw.


## License

- **Code** (files in the `R/` directory) may be released under the MIT License (recommended) – see the `LICENSE` file if present.
- The **thesis PDF** (`docs/`) and the **dataset** (`data/`) are **not** covered by the MIT License.  
  They are included only for transparency and replication and may not be redistributed or used commercially without my permission.
