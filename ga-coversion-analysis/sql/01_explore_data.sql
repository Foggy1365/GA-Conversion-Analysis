SELECT
  date,
  fullVisitorId,
  device.deviceCategory,
  device.operatingSystem,
  geoNetwork.country,
  trafficSource.source,
  totals.visits,
  totals.pageviews,
  totals.transactions,
  totals.transactionRevenue
FROM `bigquery-public-data.google_analytics_sample.ga_sessions_*`
WHERE _TABLE_SUFFIX BETWEEN '20170101' AND '20170131'
LIMIT 100