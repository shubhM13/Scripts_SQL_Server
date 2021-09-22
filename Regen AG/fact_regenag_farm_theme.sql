drop table [dwh].[AT_CriteriaToCriteriaGroup];

select * from [AUDIT].[WaterMark]

drop table [dm].[fact_nsc_regenag_farm_info];
drop table [dm].[fact_nsc_regenag_theme];

select * from [dm].[fact_nsc_regenag_farm_info];
select * from [dm].[fact_nsc_regenag_farm_theme];
select * from dm.country_code_mapping;




[dwh].[AT_Observation]
[dm].[dim_employee]
[dm].[dim_geonode_flat]
[dm].[dim_entity_master]
[dm].[dim_list_option]
[dm].[dim_organisation]


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 7th Sept 2021
 PURPOSE    : Regen AG Farm Theme
 *******************************************/
--drop view [dm].[view_fact_regenag_farm_theme]	
CREATE VIEW [dm].[view_fact_regenag_farm_theme]
AS
(
		SELECT A.templateId
			,B.classification1
			,B.classification2
			,B.classification3
			,A.criteriaId
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
		WHERE A.templateId = 'NC_REG_AGRI_THEME_TMPLT'
		);

DROP TABLE [dm].[fact_nsc_regenag_farm_theme];

SELECT *
INTO [dm].[fact_regenag_farm_theme]
FROM [dm].[view_fact_regenag_farm_theme];

ALTER TABLE [dm].[fact_regenag_farm_theme] ADD CONSTRAINT PK_fact_regenag_farm_theme PRIMARY KEY (observationId);
