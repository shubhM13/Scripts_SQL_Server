/****** Object:  View [dm].[view_criteria_topic]    Script Date: 29-06-2021 13:37:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
/*******************************************
 Author     : Shubham Mishra
 Created On : 13th June, 2021
 PURPOSE    : Bridge table between criteria to template
 *******************************************/
--drop view [dm].[view_bridge_nsp_criteria_to_topic]
CREATE VIEW [dm].[view_bridge_nsp_criteria_to_topic]
AS
(
		SELECT DISTINCT A.criteriaId
						,A.topicCode
						,ISNULL(E.label, '') AS topicTxt
		FROM dwh.AT_CriteriaToTopic AS A
		INNER JOIN [dwh].[AT_TemplateToCriteria] AS B
		ON A.criteriaId = B.criteriaId
		INNER JOIN dwh.AT_Template AS C
		ON B.templateId = C.templateId
		AND B.templateId NOT LIKE '%NESCAFE%'
		INNER JOIN dwh.CT_Organisation AS D
		ON C.organisationId = D.organisationId
        AND D.organisationId NOT LIKE '%NESCAFE%'
		AND D.lineOfBusiness IN ('GLOBAL', 'NESPRESSO')
		LEFT JOIN [dm].[dim_list_option] AS E ON E.setId = 'TOPIC'
			AND E.itemCode = A.topicCode
		);
GO

select distinct observationCriteriaId 
from dm.fact_nsp_assessment_analysis
EXCEPT 
select distinct criteriaId
from [dm].[bridge_nsp_criteria_to_template];

drop table [dm].[bridge_nsp_criteria_to_topic];

select * into
[dm].[bridge_nsp_criteria_to_topic]
from [dm].[view_bridge_nsp_criteria_to_topic];

ALTER TABLE [dm].[bridge_nsp_criteria_to_topic] ADD CONSTRAINT brdgNspCriteriaToTopic PRIMARY KEY (criteriaId, topicCode);

select * from [dm].[bridge_nsp_criteria_to_topic];

EXEC dm.GenerateMergeSQL 'dm', 'bridge_nsp_criteria_to_topic', 'dm', 'bridge_nsp_criteria_to_topic';