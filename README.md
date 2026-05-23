# Google Merchandise Store: Desktop vs Mobile Performance Analysis

Statistical analysis of conversion behavior across device types using Google Analytics data on BigQuery, with hypothesis testing in Excel and an executive dashboard in Power BI.

![Dashboard Preview](docs/dashboard_preview.png)

## TL;DR

Desktop users on the Google Merchandise Store convert at **3.5x** the rate of mobile users (1.41% vs 0.40%) AND spend **77% more per order** ($148.54 vs $83.84). Combined, desktop sessions generate **~6x more revenue per session** than mobile. Both findings are statistically significant (chi-square p<0.001, Welch's t-test p=0.019), suggesting mobile UX is a high-priority area for investment.

## Business Question

Across 61,952 sessions in January 2017, is there a statistically significant difference in purchase behavior between desktop and mobile users? If so, what's the practical impact on revenue?

## Tools Used

- **SQL** (Google BigQuery) — Querying the Google Analytics 360 sample dataset
- **Excel** — Hypothesis testing (chi-square, Welch's t-test), confidence intervals
- **Power BI** — Executive dashboard with statistical visualizations

## Methodology

### 1. Data Extraction (SQL on BigQuery)
- Source: `bigquery-public-data.google_analytics_sample.ga_sessions_*`
- Scope: January 2017 (31 daily tables, ~62K sessions)
- Worked with nested `STRUCT` fields (`totals`, `device`, `geoNetwork`) and handled GA's micros-to-USD revenue conversion
- Excluded tablet sessions (n=2,742) due to insufficient sample for reliable testing

### 2. Statistical Testing (Excel)
- **Chi-square test of independence** on a 2x2 contingency table (device × purchase outcome)
- **Welch's two-sample t-test** comparing AOV between desktop and mobile converters
- 95% confidence intervals computed for both conversion rates

### 3. Visualization (Power BI)
- Pre-aggregated summary CSVs loaded into Power BI
- KPI cards + 4 supporting visuals on a single dashboard page
- Error bars visualize confidence intervals directly on the conversion rate chart

## Key Findings

| Metric | Desktop | Mobile | Test | p-value |
|---|---|---|---|---|
| Conversion rate | 1.41% (CI: 1.30%-1.52%) | 0.40% (CI: 0.31%-0.50%) | Chi-square | 1.3 × 10⁻²⁷ |
| AOV (mean) | $148.54 (n=614) | $83.84 (n=73) | Welch's t-test | 0.019 |
| AOV (median) | $51.00 | $22.44 | — | — |
| Revenue per session | $2.09 | $0.34 | — | — |

**Practical significance:** Desktop generates **6.1x** more revenue per session than mobile via the compounded effect of higher conversion AND higher AOV.

## Caveats & Limitations

- **Observational data, not a randomized A/B test.** Users self-select into device. Confounders (intent, time-of-day, traffic source) are not controlled for. Causal claims are not appropriate.
- **Revenue data is right-skewed.** Means are inflated by outliers; medians are reported alongside for transparency. A Mann-Whitney U test would be a more rigorous follow-up for the AOV comparison.
- **One mobile transaction had null revenue** and was excluded from AOV analysis (73 of 74 mobile conversions used in t-test).
- **Single-month snapshot** (January 2017). Seasonality not controlled for.

## Repository Structure

- `sql/` — All BigQuery SQL files with inline documentation
- `data/` — Exported CSVs (queried from BigQuery)
- `excel/` — Statistical test workbook (chi-square and t-test)
- `powerbi/` — Power BI dashboard file (.pbix)
- `docs/` — Dashboard preview image and supporting screenshots

## How to Reproduce

1. Get a free Google Cloud account and access BigQuery (1TB free queries/month).
2. Run the SQL files in `/sql/` in numerical order against `bigquery-public-data.google_analytics_sample.ga_sessions_*`.
3. Export the results to CSV (matching files in `/data/`).
4. Open `excel/statistical_tests.xlsx` to see the chi-square and t-test setup.
5. Open `powerbi/ga_conversion_dashboard.pbix` in Power BI Desktop (free).

## About

Built as a portfolio project demonstrating end-to-end analyst workflow: data extraction (SQL/cloud), statistical analysis (hypothesis testing with appropriate effect sizes and confidence intervals), and stakeholder communication (executive dashboard).

**Author:** Jonathan Fagoaga | [LinkedIn](https://linkedin.com/in/your-handle)
