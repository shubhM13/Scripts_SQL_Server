/****** Object:  View [dm].[view_fact_nsc_event_analysis]    Script Date: 13/05/2021 8:21:58 AM ******/
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
--drop view dm.view_fact_nsc_event_analysis				
CREATE VIEW [dm].[view_fact_nsc_event_analysis]
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
					'NESCAFE'
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
							AND Q.lineOfBusiness IN ('GLOBAL', 'NESCAFE')
							)
		);
GO

select * from (select eventId, count(*) AS count from [dm].[view_fact_nsc_event_analysis] group by eventId) AS A where A.count > 1;

select * from [dm].[view_fact_nsc_event_analysis]
where eventId = '8C933A59EC2969FDE10000000A4E71D5'

drop table [dm].[fact_nsc_event_analysis];

select * into
[dm].[fact_nsc_event_analysis]
from [dm].[view_fact_nsc_event_analysis];

ALTER TABLE [dm].[fact_nsc_event_analysis] ADD CONSTRAINT factnscEvent PRIMARY KEY (eventId);

select count(*) from [dm].[fact_nsc_event_analysis];

select * from [dm].[fact_nsc_event_analysis] where eventId NOT IN (select distinct eventId from [dm].[bridge_nsc_event_to_entity]);
select * from [dm].[fact_nsc_event_analysis] where employeeId NOT IN (select distinct employeeId from [dm].[dim_nsc_employee])

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

/****** Object:  View [dm].[view_fact_nsc_event_analysis]    Script Date: 14/05/2021 2:39:12 AM ******/
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
--drop view dm.view_fact_nsc_event_analysis				
CREATE VIEW [dm].[view_fact_nsc_event_analysis]
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
					'NESCAFE'
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
							AND Q.lineOfBusiness IN ('GLOBAL', 'NESCAFE')
							)
		);
GO

/****** Object:  Table [dm].[fact_nsc_event_analysis]    Script Date: 14/05/2021 2:38:14 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dm].[fact_nsc_event_analysis](
	[eventId] [varchar](50) NOT NULL,
	[employeeId] [varchar](50) NULL,
	[eventStartDate] [date] NULL,
	[eventStartDateKey] [int] NULL,
	[eventEndDate] [date] NULL,
	[eventEndDateKey] [int] NULL,
 CONSTRAINT [factnscEvent] PRIMARY KEY CLUSTERED 
(
	[eventId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dm].[fact_nsc_event_analysis]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_event_analysis_dim_date] FOREIGN KEY([eventStartDateKey])
REFERENCES [dm].[dim_date] ([DateKey])
GO

ALTER TABLE [dm].[fact_nsc_event_analysis] CHECK CONSTRAINT [FK_fact_nsc_event_analysis_dim_date]
GO

ALTER TABLE [dm].[fact_nsc_event_analysis]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_event_analysis_dim_date1] FOREIGN KEY([eventEndDateKey])
REFERENCES [dm].[dim_date] ([DateKey])
GO

ALTER TABLE [dm].[fact_nsc_event_analysis] CHECK CONSTRAINT [FK_fact_nsc_event_analysis_dim_date1]
GO

ALTER TABLE [dm].[fact_nsc_event_analysis]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_event_analysis_dim_nsc_employee] FOREIGN KEY([employeeId])
REFERENCES [dm].[dim_nsc_employee] ([employeeId])
GO

ALTER TABLE [dm].[fact_nsc_event_analysis] CHECK CONSTRAINT [FK_fact_nsc_event_analysis_dim_nsc_employee]
GO

ALTER TABLE [dm].[fact_nsc_event_analysis]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_event_analysis_dim_nsc_event] FOREIGN KEY([eventId])
REFERENCES [dm].[dim_nsc_event] ([eventId])
GO

ALTER TABLE [dm].[fact_nsc_event_analysis] CHECK CONSTRAINT [FK_fact_nsc_event_analysis_dim_nsc_event]
GO


