/****** Object:  View [dm].[view_fact_nsp_event_analysis]    Script Date: 13/05/2021 8:21:58 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*******************************************
 Author     : Shubham Mishra
 Created On : 22nd April, 2021
 PURPOSE    : Event Analysis Nespresso Dataset
 *******************************************/
--drop view dm.view_fact_nsp_event_analysis				
CREATE VIEW [dm].[view_fact_nsp_event_analysis]
AS
(
		SELECT DISTINCT A.eventId
			,E.employeeId
			,CAST(A.startDate AS DATE) AS eventStartDate
			,CAST(FORMAT(CAST(A.startDate AS DATE), 'yyyyMMdd') AS INT) AS eventStartDateKey
			,CAST(A.endDate AS DATE) AS eventEndDate
			,CAST(FORMAT(CAST(A.endDate AS DATE), 'yyyyMMdd') AS INT) AS eventEndDateKey	
		FROM [dwh].[IT_Event] AS A
		INNER JOIN [dwh].[CT_Organisation] AS B WITH (NOLOCK)
			ON A.organisationId = B.organisationId
				AND B.lineOfBusiness IN (
					'NESPRESSO'
					,'GLOBAL'
					)
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
			) AS E
			ON A.eventId = E.eventId
		WHERE A.eventId IN (
							SELECT DISTINCT eventId 
							FROM [dwh].[IT_Interaction] AS P
							INNER JOIN [dwh].[CT_Organisation] AS Q
							ON P.organisationId = Q.organisationId 
							AND P.type = 'EVENT'
							AND P.status = 'COMPLETED'
							AND Q.lineOfBusiness IN ('GLOBAL', 'NESPRESSO')
							)
		);
GO

select * from (select eventId, count(*) AS count from [dm].[view_fact_nsp_event_analysis] group by eventId) AS A where A.count > 1;

select * from [dm].[view_fact_nsp_event_analysis]
where eventId = '8C933A59EC2969FDE10000000A4E71D5'

drop table [dm].[fact_nsp_event_analysis];

select * into
[dm].[fact_nsp_event_analysis]
from [dm].[view_fact_nsp_event_analysis];

ALTER TABLE [dm].[fact_nsp_event_analysis] ADD CONSTRAINT factnspEvent PRIMARY KEY (eventId);

select count(*) from [dm].[fact_nsp_event_analysis];

select * from [dm].[fact_nsp_event_analysis] where eventId NOT IN (select distinct eventId from [dm].[bridge_nsp_event_to_entity]);
select * from [dm].[fact_nsp_event_analysis] where employeeId NOT IN (select distinct employeeId from [dm].[dim_nsp_employee])

-----------------------------------------------------------------------------------------------------------------------------------------------------------------


