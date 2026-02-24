# Where Climate Risk Becomes Household Financial Instability
Assess how climate-related hazards expose households to financial instability in South Florida region.

## Getting Started: 
1. Report and presentation
2. data/: Contains cleaned datasets used for the analysis
3. notebooks/: Jupyter notebooks
4. visualizations/: Tableau visualizations and dashboard
5. scripts/: Python and SQL scripts for data analysis

### Tools:
Excel, Jupyter, Python, SQL, Tableau

### Data Sources:
This analysis integrates the following cleaned and standardized datasets:
* American Community Survey (ACS)[^1] – demographic and socioeconomic characteristics at the census tract level
* CDC Social Vulnerability Index (SVI)[^2] – measures community vulnerability across socioeconomic status, household composition, minority status, and housing/transportation
* FEMA National Risk Index (NRI)[^3] – multi-hazard risk metrics and expected annual loss estimates
* FEMA National Flood Hazard Layer (NFHL)[^4] – spatial floodplain boundaries used to determine physical flood exposure
* NOAA Billion-Dollar Disasters[^5] – historical context on the frequency and cost of extreme climate events

All tract-level datasets are joined using a standardized GEOID, while flood exposure is derived through spatial intersection with FEMA floodplain polygons (see _data/_ for questions).

The analysis will be based on the cleaned master dataset, which has 84 fields, including:
* "geoid": 11-digit census tract GEOID (state+county+tract). Join key.
* "acs_median_hh_income": ACS median household income (USD).
* "acs_population": ACS total population estimate.
* "svi_overall_pctile": CDC SVI overall percentile (0-1, higher = more vulnerable).
* "nri_composite_score": FEMA NRI composite risk score.
* "nri_eal_total_usd": FEMA NRI expected annual loss (USD), composite.
* "nfhl_in_floodplain": Boolean: tract intersects FEMA NFHL flood zone polygons.

Geographic Note: All analysis is conducted at the census tract level. City and ZIP fields are provided for interpretability [^6].
  

## Problem Definition
Although South Florida is widely recognized as a climate-vulnerable region, climate risk is unevenly distributed across communities. Many households face elevated financial risk due to the combined effects of hazard exposure, limited adaptive capacity, and underlying social vulnerability.

### Relevance:
Understanding how climate-related hazards translate into household financial instability at the census tract level is crucial for several reasons:
* Policymakers and resilience planners require tract-level evidence to prioritize adaptation investments, infrastructure upgrades, and equitable resilience funding where financial strain is most concentrated.
* Housing, insurance, and financial stability stakeholders need localized insights into where repeated climate losses may accelerate wealth erosion, increase uninsured burdens, and heighten displacement risks.
* Equity-focused organizations can use integrated hazard and vulnerability data to identify communities experiencing compounded exposure and limited adaptive capacity.
* Researchers and analysts benefit from moving beyond regional averages to quantify how expected annual losses, floodplain overlap, and social vulnerability interact to shape household-level climate risk outcomes.

## Hypothesis
Households located in census tracts with higher exposure to climate-related hazards (particularly flooding and hurricanes) experience greater financial instability due to elevated expected losses and higher social vulnerability, increasing the risk of wealth erosion, uninsured financial burden, and potential displacement.

## Vision
To support climate-informed, equity-focused policy decisions by revealing how climate hazards translate into measurable household-level financial strain and wealth risk at the census tract scale.

## Objective
The primary objective of this analysis is to gain a comprehensive understanding of how climate-related hazards in South Florida expose households to financial instability and wealth risk at the census tract level. By integrating multiple federal datasets and examining the interaction between hazard exposure, expected annual losses, uninsured burden, and social vulnerability, this report aims to address the following objectives:
* Visualize the spatial distribution of climate hazard exposure and floodplain overlap across South Florida census tracts to identify areas with heightened physical risk.
* Examine how social vulnerability varies across tracts with differing levels of climate hazard exposure, highlighting communities where limited adaptive capacity may amplify financial impacts.
* Assess expected annual losses as a proxy for household wealth risk, evaluating how financial exposure differs across tracts facing similar climate hazards.
* Identify census tracts where climate risk and social vulnerability intersect, highlighting priority areas for equitable climate adaptation, resilience planning, and policy intervention.

## Review of the Literature
Recent research shows that climate-related hazards like flooding and hurricanes interact with socioeconomic vulnerability to create unequal financial outcomes for households and communities. These studies demonstrate that households with limited financial resources, high debt, or inadequate insurance face much larger economic losses when disasters strike, indicating that understanding physical risk alone is not enough [^7]. Researchers studying social vulnerability indices have found that communities with higher social vulnerability (characterized by poverty, limited ability to adapt, and demographic disadvantages) also tend to show lower resilience and slower recovery after climate events, highlighting the need to integrate social and economic risk indicators into climate assessments [^8]. Systematic reviews of climate inequalities emphasize that unequal access to adaptation and mitigation resources can worsen disparities in climate impacts across neighborhoods and demographic groups, reinforcing the connection between social vulnerability and material losses from climate hazards [^9]. Institutional frameworks for assessing climate-related risk, including physical risk metrics developed by central banks and financial authorities, stress the importance of combining hazard exposure with financial impact indicators to understand how climate risk moves through economic systems and affects household wealth stability [^10]. Together, this body of evidence supports integrated, place-based climate risk assessment approaches that combine hazard exposure, social vulnerability, and financial loss metrics at detailed geographic scales.

## Key Insights
* Across South Florida census tracts, flooding and hurricanes account for approximately 88% of total expected annual climate-related financial losses, confirming water-related hazards as the dominant driver of household financial risk in the region.
* Lower-income households in Homestead experience the highest uninsured burden under 3–5% income loss conditions.

### Dashboard
<img width="2880" height="1736" alt="Data Project 12 Dec 2025 - Dashboard 1" src="https://github.com/user-attachments/assets/5d4e8910-ae43-4903-bd8f-71e252a29a14" />
<img width="2880" height="1736" alt="Data Project 12 Dec 2025 - Dashboard 1 2" src="https://github.com/user-attachments/assets/7e3368c1-070b-49c1-969f-cc3f7a02dcce" />
<img width="2880" height="1740" alt="Data Project 12 Dec 2025 - Dashboard 2" src="https://github.com/user-attachments/assets/e69cde37-99b9-4680-8d6e-0663cf13db9e" />


## Next Steps
* Design industry-specific workshops to highlight the benefits and applications of machine learning in various sectors.
* Organize events that promote collaboration and idea exchange among professionals to accelerate ML adoption within organizations.
* Provide training programs in machine learning to help professionals enhance their skills, stay current with industry trends, and boost their career prospects.
* Support regulations that encourage innovation while ensuring privacy, security, and fairness, fostering greater confidence in ML technologies.
* Continuously use dataset insights to update and improve the educational sessions, ensuring they remain relevant and effective.

## Contact
For any inquiries or feedback, please contact acsoteldo01@gmail.com.

## References
[^1]: Data Source: American Community Survey (ACS)
https://api.census.gov/data/key_signup.html

[^2]: Data Source: CDC Social Vulnerability Index (SVI)
https://svi.cdc.gov/dataDownloads/data-download.html

[^3]: Data Source: FEMA National Risk Index (NRI)
https://resilience.climate.gov/datasets/FEMA%3A%3Anational-risk-index-census-tracts/about

[^4]: Data Source: FEMA National Flood Hazard Layer (NFHL)
https://www.arcgis.com/home/item.html?id=2b245b7f816044d7a779a61a5844be23&sublayer=0 

[^5]: Data Source: NOAA Billion-Dollar Disasters
https://www.ncei.noaa.gov/access/metadata/landing-page/bin/iso?id=gov.noaa.nodc:0209268

[^6]: Data Source: Census Tiger
https://www.census.gov/geographies/mapping-files/time-series/geo/tiger-line-file.html

[^7]: Household financial vulnerabilities and physical climate risks 
https://www.bankofcanada.ca/2021/08/staff-analytical-note-2021-19

[^8]: Assessing the Relationship Between Social Vulnerability and Community Resilience to Hazards
https://pmc.ncbi.nlm.nih.gov/articles/PMC5739329

[^9]: Climate change inequalities
https://www.sciencedirect.com/science/article/pii/S1462901125000371

[^10]: Leveraging physical climate risk data
https://www.ngfs.net/system/files/2025-09/NGFS_information%20note_Leveraging%20physical%20climate%20risk%20data.pdf
