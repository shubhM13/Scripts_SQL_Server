/*******************************************
 Author     : Shubham Mishra
 Created On : 25th March
 PURPOSE    : User Activity Model
 *******************************************/
--drop view dm.view_fact_user_activity;
CREATE VIEW dm.view_fact_user_activity
AS
(
		SELECT  A.userName
				,A.employeeId
				,ISNULL(YEAR(D.LAST_SUCCESSFUL_CONNECT), 0) AS year
				,ISNULL(MONTH(D.LAST_SUCCESSFUL_CONNECT), 0) AS month
				,D.LAST_SUCCESSFUL_CONNECT AS last_successful_connect_ts
				,CAST(D.LAST_SUCCESSFUL_CONNECT AS DATE) AS last_successful_connect_dt
				,CAST(FORMAT(CAST(D.LAST_SUCCESSFUL_CONNECT AS DATE), 'yyyyMMdd') AS INT) AS date_key
		FROM [dwh].[CT_Employee] AS A
		INNER JOIN [dwh].[CT_Organisation] AS B ON A.organisationId = B.organisationId
	    LEFT JOIN (
			SELECT * FROM
				 (
				 SELECT L.USER_NAME 
					  , L.LAST_SUCCESSFUL_CONNECT
					  , M.Month
					  , M.Year
					  , RANK() OVER (PARTITION BY L.USER_NAME, M.Month, M.Year ORDER BY L.LAST_SUCCESSFUL_CONNECT DESC) AS rnk
				   FROM [dwh].[SYS_USERS_HISTORY] AS L
				   INNER JOIN dm.dim_date AS M
				   ON CAST(FORMAT(cast(L.LAST_SUCCESSFUL_CONNECT AS DATE), 'yyyyMMdd') AS INT) = M.DateKey
				 ) AS P
				 where P.rnk = 1) AS D ON A.userName = D.USER_NAME
		AND D.LAST_SUCCESSFUL_CONNECT IS NOT NULL
		AND D.USER_NAME IS NOT NULL
		AND D.LAST_SUCCESSFUL_CONNECT >= Convert(datetime, '2021-05-01')
		);

select count(userName) from dm.view_user_activity;
select count(distinct userName) from dm.view_user_activity;

DROP TABLE dm.fact_user_activity;

SELECT *
INTO dm.fact_user_activity
FROM dm.view_fact_user_activity;


--ALTER TABLE dm.fact_user_activity ALTER COLUMN userName NVARCHAR(100) NOT NULL;
--ALTER TABLE dm.fact_user_activity ALTER COLUMN last_successful_connect_ts datetime NOT NULL;
--ALTER TABLE dm.fact_user_activity ADD CONSTRAINT dimUserAct_pk PRIMARY KEY (userName, year, month);

SELECT *
FROM dm.view_fact_user_activity;


SELECT *
FROM dm.fact_user_activity;

-------merge query test -------
truncate table dm.fact_user_activity;

EXEC dm.GenerateMergeSQL 'dm', 'fact_user_activity', 'dm', 'fact_user_activity'
