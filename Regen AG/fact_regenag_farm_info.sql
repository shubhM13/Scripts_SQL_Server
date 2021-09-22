SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 7th Sept 2021
 PURPOSE    : Regen AG Farm Info
 *******************************************/
--drop view [dm].[view_fact_regenag_farm_info]	
CREATE VIEW [dm].[view_fact_regenag_farm_info]
AS
(
		SELECT A.templateId
			,X.criteriaId
			,D.criteriaEvaluationContext
			,B.parentCriteriaId
			,C.title
			,C.shortDescription
			,B.answerListSetId
			,Y.label AS answerCodeTxt
			,Z.score AS answerScore
			,ISNULL(X.observationId, 'N/A') AS observationId
			,X.STATUS
			,X.type
			,X.obsDateTime
			,X.entityId
			,ISNULL(X.interactionId, 'N/A') AS interactionId
			,X.answerType
			,X.answerNumber
			,X.answerCode
			,X.answerText
			,X.unitOfMeasure
			,X.currencyCode
			,X.isLatest
			,X.isLatestByYear
			,P.employeeId
			,P.organisationId
		FROM dwh.AT_TemplateToCriteria AS A
		INNER JOIN dwh.AT_Criteria AS B ON A.criteriaId = B.criteriaId
		INNER JOIN dwh.AT_Criteria_Txt AS C ON B.criteriaId = C.criteriaId
		INNER JOIN dwh.AT_CriteriaToCriteriaGroup AS D ON C.criteriaId = D.criteriaId
		LEFT JOIN dwh.AT_Observation AS X ON B.criteriaId = X.criteriaId
		LEFT JOIN dwh.IT_Interaction AS P ON X.interactionId = P.interactionId
		LEFT JOIN dwh.CT_ListOption_Txt AS Y ON X.answerCode = Y.itemCode
			AND Y.LANGUAGE = 'E'
			AND Y.setId = B.answerListSetId
		LEFT JOIN dwh.CT_ListOption AS Z ON Y.itemCode = Z.itemCode
			AND Z.setId = Y.setId
		WHERE A.templateId = 'NC_REG_AGRI_FARM_INFO_TMPLT'
		);

drop table [dm].[fact_regenag_farm_info];

select *
into [dm].[fact_regenag_farm_info]
from [dm].[view_fact_regenag_farm_info];

ALTER TABLE [dm].[fact_regenag_farm_info]
ADD CONSTRAINT PK_fact_regenag_farm_info
PRIMARY KEY (observationId);