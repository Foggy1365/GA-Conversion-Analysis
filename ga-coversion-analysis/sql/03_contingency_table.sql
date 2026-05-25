SELECT
  device.deviceCategory AS device,
  COUNT(*) AS total_sessions,
  COUNTIF(totals.transactions IS NOT NULL) AS converted_sessions,
  COUNT(*) - COUNTIF(totals.transactions IS NOT NULL) AS non_converted_sessions,
  ROUND(COUNTIF(totals.transactions IS NOT NULL) / COUNT(*) * 100, 3) AS conversion_rate_pct
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE _TABLE_SUFFIX BETWEEN '20170101' AND '20170131'
  AND device.deviceCategory IN ('desktop', 'mobile')
GROUP BY device
ORDER BY total_sessions DESC