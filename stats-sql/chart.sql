-- Active wallets
SELECT COUNT(*) AS "count"
FROM (SELECT "safe_gnosis_mainnet"."transactions"."wallet" AS "wallet", COUNT(*) AS "count" FROM "safe_gnosis_mainnet"."transactions"
GROUP BY "safe_gnosis_mainnet"."transactions"."wallet"
ORDER BY "safe_gnosis_mainnet"."transactions"."wallet" ASC) AS "source"
WHERE "source"."count" > 1


-- Average Transaction Time on Safe
SELECT AVG(transaction_time) AS average_transaction_time
FROM (
    SELECT EXTRACT(SECOND FROM (MAX(to_timestamp("stamp")) - MIN(to_timestamp("stamp")))) AS transaction_time
    FROM "safe_gnosis_mainnet"."transactions"
    ) AS subquery;


-- Daily multi signature wallet: Bar charts
SELECT date_trunc('day', to_timestamp("stamp")) AS "Month"
		,COUNT("id") AS "count"
	FROM "safe_gnosis_mainnet"."wallets"
	GROUP BY date_trunc('day', to_timestamp("stamp"))
		,"creator"
	ORDER BY date_trunc('day', to_timestamp("stamp")) ASC


-- Monthly active wallets
SELECT date_trunc('month', a."month") AS "Month"
	,COUNT(a."count") AS "Count"
FROM (
	SELECT date_trunc('month', to_timestamp("stamp")) AS "month"
		,"wallet"
		,COUNT("wallet") AS "count"
	FROM "safe_gnosis_mainnet"."transactions"
	GROUP BY date_trunc('month', to_timestamp("stamp"))
		,"wallet"
	ORDER BY date_trunc('month', to_timestamp("stamp")) ASC
	) a
WHERE a."count" > 1
GROUP BY date_trunc('month', a."month")
ORDER BY date_trunc('month', a."month") ASC


-- Monthly unique wallets
SELECT date_trunc('Month', to_timestamp("stamp")) AS "Month"
	,count(DISTINCT "wallet") AS "Wallet Count"
FROM "safe_gnosis_mainnet"."transactions"
GROUP BY date_trunc('Month', to_timestamp("stamp"))
ORDER BY date_trunc('Month', to_timestamp("stamp")) ASC


-- Total transactions
SELECT COUNT(*) AS "count"
FROM "safe_gnosis_mainnet"."transactions"
