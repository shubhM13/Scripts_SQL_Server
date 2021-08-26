/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_fact_nsc_event_analysis]    Script Date: 22/07/2021 10:58:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 22nd April, 2021
 PURPOSE    : Event Analysis Nescafe Dataset
 Modified By: Shubham Mishra On 13th May // Code review and refactor
 *******************************************/
--drop view dm.view_inc_fact_nsc_event_analysis				
CREATE VIEW [dm].[view_inc_fact_nsc_event_analysis]
AS
(
		SELECT DISTINCT A.eventId
			,E.employeeId
			,CAST(A.startDate AS DATE) AS eventStartDate
			,CAST(FORMAT(CAST(A.startDate AS DATE), 'yyyyMMdd') AS INT) AS eventStartDateKey
			,CAST(A.endDate AS DATE) AS eventEndDate
			,CAST(FORMAT(CAST(A.endDate AS DATE), 'yyyyMMdd') AS INT) AS eventEndDateKey
		FROM [dwh].[IT_Event] AS A
		INNER JOIN [dwh].[CT_Organisation] AS B WITH (NOLOCK) ON A.organisationId = B.organisationId
			AND B.lineOfBusiness IN (
				'NESCAFE'
				,'GLOBAL'
				)
		AND A.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'IT' and sqltablename = 'Event')
		LEFT OUTER JOIN (
			SELECT *
			FROM (
				SELECT employeeId
					,eventid
					,RANK() OVER (
						PARTITION BY eventId ORDER BY employeeId DESC
						) AS rnk
				FROM [dwh].[IT_EventToEmployee]
				) AS Q
			WHERE Q.rnk = 1
			) AS E ON A.eventId = E.eventId
		WHERE A.eventId IN (
				SELECT DISTINCT eventId
				FROM [dwh].[IT_Interaction] AS P
				INNER JOIN [dwh].[CT_Organisation] AS Q ON P.organisationId = Q.organisationId
					AND P.type = 'EVENT'
					AND P.STATUS = 'COMPLETED'
					AND Q.lineOfBusiness IN (
						'GLOBAL'
						,'NESCAFE'
						)
				)
		);
GO