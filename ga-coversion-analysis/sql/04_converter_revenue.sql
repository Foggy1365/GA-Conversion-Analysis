SELECT
  device.deviceCategory AS device,
  fullVisitorId,
  visitId,
  totals.transactions AS transactions,
  ROUND(totals.transactionRevenue / 1000000, 2) AS revenue_usd
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE _TABLE_SUFFIX BETWEEN '20170101' AND '20170131'
  AND device.deviceCategory IN ('desktop', 'mobile')
  AND totals.transactions IS NOT NULL
  AND totals.transactionRevenue IS NOT NULL
ORDER BY device, revenue_usd DESC