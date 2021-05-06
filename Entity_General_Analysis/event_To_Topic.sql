SET ANSI_NULLS ON
GO

 

SET QUOTED_IDENTIFIER ON
GO

 
/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 29th April, 2021
 PURPOSE    : Dim Event Topic Nespresso Dataset
 *******************************************/
--drop view dm.view_dim_nsp_EventTopic
CREATE VIEW [dm].[view_dim_nsp_EventTopic]
AS
(
        SELECT DISTINCT A.eventId AS eventId 
            ,ISNULL(A.topicCode, '') AS topicCode
            ,ISNULL(B.label, '') AS topicName
        FROM [dwh].[IT_EventToTopic] AS A
		INNER JOIN [dwh].[IT_Event] AS C
		ON A.eventId = C.eventId
		INNER JOIN [dwh].[CT_Organisation] AS D
		ON D.organisationId = C.organisationId
		AND D.lineOfBusiness IN ('GLOBAL', 'NESPRESSO')
        LEFT JOIN [dm].[dim_list_option] AS B ON A.topicCode = B.itemCode
        );
GO

select * from [dm].[view_dim_nsp_EventTopic];

drop table  [dm].[dim_nsp_EventTopic];

select *
into [dm].[dim_nsp_EventTopic]
from [dm].[view_dim_nsp_EventTopic];

ALTER TABLE [dm].[dim_nsp_EventTopic] ADD CONSTRAINT dimNspEventToTopic_pk PRIMARY KEY (eventId, topicCode);