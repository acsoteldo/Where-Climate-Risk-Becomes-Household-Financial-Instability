-- Descriptive Analysis
-- Sanity checks
SELECT
  COUNT(*) AS tracts,
  SUM(CASE WHEN acs_median_hh_income IS NULL THEN 1 ELSE 0 END) AS null_income,
  SUM(CASE WHEN acs_median_hh_income <= 0 THEN 1 ELSE 0 END) AS nonpositive_income,
  SUM(CASE WHEN acs_households IS NULL OR acs_households = 0 THEN 1 ELSE 0 END) AS zero_households,
  SUM(CASE WHEN nri_top3_hazards_eal_total_usd IS NULL THEN 1 ELSE 0 END) AS null_eal_total
FROM sf_master_tracts;

-- County summary (weighted averages)
SELECT
  county_name,
  COUNT(*) AS tracts,
  SUM(acs_households) AS households,
  SUM(nri_top3_hazards_eal_total_usd) AS total_eal_usd,
  SUM(nri_top3_hazards_eal_total_usd) / NULLIF(SUM(acs_households), 0) AS eal_per_household_usd,
  SUM(acs_median_hh_income * acs_households) / NULLIF(SUM(acs_households), 0) AS weighted_income_usd,
  (SUM(nri_top3_hazards_eal_total_usd) / NULLIF(SUM(acs_households), 0))
   /
  NULLIF(SUM(acs_median_hh_income * acs_households) / NULLIF(SUM(acs_households), 0), 0) AS income_loss_ratio
FROM sf_master_tracts
GROUP BY county_name
ORDER BY income_loss_ratio DESC;

-- Segmentation Analysis
-- Top N cities by total EAL + share of region EAL
WITH city_totals AS (
  SELECT
    city_name,
    SUM(nri_top3_hazards_eal_total_usd) AS city_total_eal
  FROM sf_master_tracts
  WHERE city_name IS NOT NULL
  GROUP BY city_name
),
ranked AS (
  SELECT
    city_name,
    city_total_eal,
    DENSE_RANK() OVER (ORDER BY city_total_eal DESC) AS rnk
  FROM city_totals
),
region AS (
  SELECT SUM(city_total_eal) AS region_total_eal FROM city_totals
)
SELECT
  SUM(CASE WHEN rnk <= 15 THEN city_total_eal ELSE 0 END) AS topN_eal,
  region_total_eal,
  (SUM(CASE WHEN rnk <= 15 THEN city_total_eal ELSE 0 END) / NULLIF(region_total_eal, 0)) AS topN_share
FROM ranked
CROSS JOIN region;

-- Distribution of tracts by income loss category
SELECT
  CASE
    WHEN acs_median_hh_income > 0 AND nri_top3_eal_per_household_usd IS NOT NULL THEN
      CASE
        WHEN (nri_top3_eal_per_household_usd / acs_median_hh_income) < 0.01 THEN 'Low (<1%)'
        WHEN (nri_top3_eal_per_household_usd / acs_median_hh_income) < 0.03 THEN 'Moderate (1–3%)'
        ELSE 'High (>=3%)'
      END
    ELSE 'Missing'
  END AS income_loss_category,
  COUNT(*) AS tracts,
  SUM(acs_households) AS households
FROM sf_master_tracts
GROUP BY income_loss_category
ORDER BY households DESC;

--
WITH labeled AS (
  SELECT
    *,
    CASE
      WHEN acs_median_hh_income > 0
       AND nri_top3_eal_per_household_usd / acs_median_hh_income >= 0.05
      THEN 1 ELSE 0
    END AS is_severe
  FROM sf_master_tracts
)
SELECT
  is_severe,
  COUNT(*) AS tracts,
  AVG(svi_overall_pctile) AS avg_svi_pctile,
  AVG(svi_unemployed_pct) AS avg_unemployed_pct,
  AVG(svi_housing_cost_burden_pct) AS avg_housing_burden_pct,
  AVG(nfhl_in_floodplain::int) AS pct_in_floodplain
FROM labeled
GROUP BY is_severe
ORDER BY is_severe DESC;
