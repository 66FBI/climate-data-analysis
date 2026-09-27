# Climate Data Analysis

Statistical analysis of long-term temperature and precipitation records from meteorological stations in northeastern Poland using **R**.

The project analyzes monthly climate observations from **Białystok and Suwałki** over the period **1951–2024**, progressing from descriptive climate characterization to long-term trend estimation, decadal analysis and inter-station correlation analysis.

## Project Overview

The project consists of two complementary climate analyses.

### 1. Białystok Climate Analysis

The first stage focuses on characterizing long-term climate variability at the Białystok meteorological station.

The analysis covers:

- monthly temperature and precipitation distributions,
- descriptive statistics,
- seasonal differences in climate variability,
- distributions for representative months,
- year-to-year variability,
- long-term linear trends,
- decadal changes in temperature and precipitation.

Four months representing different seasons were selected for detailed analysis:

- February
- May
- August
- November

### 2. Białystok–Suwałki Comparative Analysis

The second stage extends the analysis to the Suwałki meteorological station and compares both locations over their common observation period.

The analysis includes:

- comparison of monthly climate distributions,
- long-term temperature and precipitation trends,
- statistical significance testing,
- rate of change per decade,
- comparison of trends between stations,
- Pearson correlation analysis,
- Spearman rank correlation analysis.

## Data

The analysis uses:

- **mean monthly air temperature**
- **monthly precipitation totals**

for meteorological stations in **Białystok** and **Suwałki**.

The available observations cover **1951–2024**. Incomplete observations from 2025 were excluded from the analysis.

Meteorological data were obtained from **Meteomodel**, while station metadata were obtained from **IMGW**.

```text
bialystok_temperature.txt
bialystok_precipitation.txt
suwalki_temperature.txt
suwalki_precipitation.txt
```

## Methodology

### Data Preparation

The source tables were imported into R and cleaned before analysis.

The preprocessing workflow included:

- removal of unnecessary columns,
- exclusion of incomplete observations,
- conversion of problematic data types,
- transformation between wide and long data formats,
- selection of a common observation period,
- separation of selected months and climate variables.

### Descriptive Climate Analysis

Monthly climate characteristics were examined using **boxplots** and descriptive statistics.

For temperature and precipitation, the analysis calculated statistics including:

- mean,
- median,
- standard deviation,
- variance,
- minimum,
- maximum.

This provides an overview of the annual climate cycle as well as differences in variability between individual months.

### Seasonal Distribution Analysis

Four representative months — February, May, August and November — were selected to represent different seasons.

Histograms were used to investigate the distributions of temperature and precipitation and identify:

- distribution shape,
- typical ranges,
- variability,
- unusual observations.

### Temporal Variability

Selected temperature and precipitation series were analyzed across the complete observation period.

Time-series plots were combined with **linear regression models** to investigate:

- year-to-year variability,
- long-term increases or decreases,
- unusual observations,
- differences between temperature and precipitation variability.

### Decadal Analysis

For the Białystok station, observations were aggregated into complete ten-year periods.

Decadal means were calculated for the selected temperature and precipitation variables to examine how climate conditions changed between successive decades.

Only complete decades were included in this part of the analysis.

### Long-Term Trend Analysis

The comparative analysis evaluates long-term trends at both Białystok and Suwałki.

For each selected month, station and climate variable, a linear model was used to estimate:

- direction of the trend,
- trend magnitude,
- rate of change per decade,
- p-value,
- statistical significance.

A threshold of **p < 0.05** was used to identify statistically significant linear trends.

A total of **16 temperature and precipitation trends** were evaluated across the two stations.

### Correlation Analysis

Relationships between corresponding climate variables recorded at Białystok and Suwałki were investigated using:

- **Pearson correlation coefficient**
- **Spearman rank correlation coefficient**

Scatter plots with regression lines were used to visualize the relationships.

Pearson correlations were additionally tested for statistical significance at **p < 0.05**, while Spearman coefficients were used to assess the strength of monotonic relationships.

## Selected Results

The analysis shows a clear seasonal climate cycle at both stations, with the highest temperatures occurring during summer and the lowest during winter.

Long-term temperature analysis identified statistically significant warming in several seasonal series. For example, February temperature increased significantly at both stations over 1951–2024.

The estimated February warming rates were approximately:

- **Białystok: +0.631 °C per decade**
- **Suwałki: +0.663 °C per decade**

Temperature patterns between Białystok and Suwałki were generally similar, although Suwałki showed lower temperatures throughout the year.

Precipitation displayed substantially greater interannual variability than temperature, particularly during the warmer part of the year.

The correlation analysis further demonstrated how temperature and precipitation variability at the two nearby stations differed in the strength and character of their relationships.

## Visualizations

The project includes a range of statistical visualizations produced with **ggplot2**, including:

- monthly boxplots,
- seasonal histograms,
- long-term time-series plots,
- linear trend plots,
- decadal change plots,
- inter-station scatter plots and regression lines.

Selected figures are available in the [`figures`](figures/) directory, while the complete analyses and interpretations are provided in the project reports.

## Repository Structure

```text
climate-data-analysis/
├── figures/
│   ├── decadal/
│   ├── seasonal/
│   └── ...
├── bialystok_climate_analysis.R
├── bialystok_suwalki_comparison.R
├── bialystok_climate_report.pdf
├── bialystok_suwalki_comparison_report.pdf
├── bialystok_temperature.txt
├── bialystok_precipitation.txt
├── suwalki_temperature.txt
├── suwalki_precipitation.txt
├── correlations.xlsx
└── README.md
```

## Technologies

- **R**
- **tidyverse**
- **dplyr**
- **tidyr**
- **ggplot2**
- **patchwork**
- descriptive statistics
- linear regression
- statistical significance testing
- Pearson correlation
- Spearman rank correlation
- climate data visualization

## Reports

Detailed methodology, results, visualizations and interpretation are available in:

- `bialystok_climate_report.pdf`
- `bialystok_suwalki_comparison_report.pdf`

## Authors

**Michał Kuśnierz**  
**Dawid Krawczyk**  
**Aleksander Drab**

Developed as part of the **Environmental Data Processing** course at **AGH University of Science and Technology**, 2025.
