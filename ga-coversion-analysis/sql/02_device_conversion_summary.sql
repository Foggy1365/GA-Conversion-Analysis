SELECT
  device.deviceCategory,
  COUNT(*) AS sessions,
  COUNTIF(totals.transactions IS NOT NULL) AS sessions_with_purchase
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE _TABLE_SUFFIX BETWEEN '20170101' AND '20170131'
GROUP BY device.deviceCategory
ORDER BY sessions DESC