/*******************************************
 Author     : Shubham Mishra
 Created On : 4th March, 2021
 PURPOSE    : Rainforest Alliance Report
 *******************************************/
--drop view dm.view_rainforest_alliance
CREATE VIEW dm.view_rainforest_alliance
AS
(
		SELECT A.[interactionId]
			,A.interactionStartDate
			,E.Year AS interactionYear
			,A.observationId
			,A.obsDate
			,F.Year AS obsYear
			,B.[personInfo.firstName] + ' ' + B.[personInfo.lastName] AS employee_name
			,C.entityName
			,C.externalSystemId AS entity_ext_Id
			,C.subcluster_name
			,C.cluster_name
			,C.country_name
			,C.unit4C
			,C.status4C
			,C.entityStatus
			,C.longX
			,C.latY
			,C.altZ
			,A.observationCriteriaId
			,A.criteriaGroupCodes
			,D.criteriaCode
			,D.criteriaTitle
			,D.criteriaShortDescription
			,A.answerType
			,ISNULL(A.answerNumber, 0) AS answerNumber
			,ISNULL(A.answerText, '') AS answerText
			,ISNULL(A.answerCodeTxt, '') AS answerCodeTxt
			,A.answerDate
			,A.answerDate2
			,ISNULL(A.multiListAnswerCodeTxt, '') AS multiListAnswerCodeTxt
			,ISNULL(A.unitOfMeasureTxt, '') AS unitOfMeasureTxt
		FROM [dm].[fact_assessment_analysis] AS A
		INNER JOIN [dm].[dim_employee] AS B
		ON A.interactionEmployeeId = B.employeeId
		INNER JOIN [dm].[dim_entity_master] AS C
		ON A.entityId = C.entityId
		INNER JOIN [dm].[dim_criteria] AS D 
		ON A.observationCriteriaId = D.criteriaId
		INNER JOIN [dm].[dim_date] AS E
		ON A.startDateKey = E.DateKey
		INNER JOIN [dm].[dim_date] AS F
		ON A.obsDateKey = F.DateKey
		WHERE A.isLatestByYear = 1
		AND A.criteriaGroupCodes LIKE 'RA,%'
		OR A.criteriaGroupCodes LIKE '%,RA,%'
		OR A.criteriaGroupCodes LIKE '%,RA'
		);

select Count(*) from dm.view_rainforest_alliance
select * from dm.view_rainforest_alliance
select COUNT(*) from [dm].[fact_assessment_analysis] where criteriaGroupCode = 'RA' AND isLatestByYear = 1

select distinct YEAR(obsDateOnly) from [dwh].[AT_Observation] AS A
INNER JOIN [dwh].[AT_CriteriaToCriteriaGroup] AS B ON A.criteriaId = B.criteriaId
AND B.groupCode = 'RA'