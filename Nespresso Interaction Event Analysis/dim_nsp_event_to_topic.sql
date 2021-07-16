-----------------------------------------------------------------------------------------

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


/*******************************************
 Author     : Shubham Mishra
 Created On : 29th April, 2021
 PURPOSE    : Dim Event Topic Nespresso Dataset
 *******************************************/
--drop view dm.view_dim_nsp_event_to_topic
CREATE VIEW [dm].[view_dim_nsp_event_to_topic]
AS
(
		SELECT DISTINCT B.eventId AS eventId
			,ISNULL(D.label, 'N/A') AS topicName
			,ISNULL(X.templateName, 'N/A') AS templateName --redundant info
		FROM [dwh].[IT_Event] AS A
        LEFT JOIN [dwh].[IT_EventToTopic] AS B
        ON B.eventId = A.eventId
		INNER JOIN [dwh].[CT_Organisation] AS C ON C.organisationId = A.organisationId
			AND C.lineOfBusiness IN (
				'GLOBAL'
				,'NESPRESSO'
				)
		LEFT JOIN [dm].[dim_list_option] AS D ON B.topicCode = D.itemCode
		LEFT JOIN (
			SELECT DISTINCT P.topicCode
				   ,R.title AS templateName
			FROM [dwh].[AT_CriteriaToTopic] AS P
			INNER JOIN [dwh].[AT_TemplateToCriteria] AS Q
			ON P.criteriaId = Q.criteriaId
			INNER JOIN [dwh].[AT_Template_Txt] AS R 
			ON Q.templateId = R.templateId
		) AS X ON B.topicCode = X.topicCode
		WHERE A.eventId IN (
				SELECT DISTINCT eventId
				FROM [dwh].[IT_Interaction] AS P
				INNER JOIN [dwh].[CT_Organisation] AS Q ON P.organisationId = Q.organisationId
					AND P.type = 'EVENT'
					AND P.STATUS = 'COMPLETED'
					AND Q.lineOfBusiness IN (
						'GLOBAL'
						,'NESPRESSO'
						)
				)
		AND A.eventId IS NOT NULL
		AND B.eventId IS NOT NULL
		);
GO

---------------------------------------------------
select * 
into [dm].[dim_nsp_event_to_topic]
from [dm].[view_dim_nsp_event_to_topic];



ALTER TABLE [dm].[dim_nsp_event_to_topic] ALTER COLUMN eventId varchar(50) NOT NULL;
ALTER TABLE [dm].[dim_nsp_event_to_topic] ALTER COLUMN topicName nvarchar(200) NOT NULL;
ALTER TABLE [dm].[dim_nsp_event_to_topic] ALTER COLUMN templateName nvarchar(200) NOT NULL;

ALTER TABLE [dm].[dim_nsp_event_to_topic] ADD CONSTRAINT dimNscEvtToTopic_pk PRIMARY KEY (eventId, topicName, templateName);
alter table [dm].[dim_nsp_event_to_topic] drop constraint dimNscEvtToTopic_pk;
--------------------------------------------------

EXEC dm.GenerateMergeSQL 'dm', 'dim_nsp_event_to_topic', 'dm', 'dim_nsp_event_to_topic'







