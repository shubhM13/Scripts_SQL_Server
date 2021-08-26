/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_fact_nsc_early_warning]    Script Date: 22/07/2021 11:03:23 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 19th April, 2021
 PURPOSE    : Early Warning Report
 *******************************************/
--drop view dm.view_inc_fact_nsc_early_warning
CREATE VIEW [dm].[view_inc_fact_nsc_early_warning]
AS
(
		SELECT DISTINCT A.*
			,count(C.[observationId]) AS assessmentYearlyCount
		FROM dm.view_inc_early_warning_base AS A
		INNER JOIN dm.view_early_warning_base AS C ON A.entityId = C.entityId
			AND A.criteriaId = C.criteriaId
		WHERE A.isLatestByYear = 1
		GROUP BY A.interactionId
			,A.interactionStartDate
			,A.startDateKey
			,A.orgName
			,A.employee_name
			,A.agronomistEmail
			,A.observationId
			,A.obsDate
			,A.obsDateKey
			,A.entityId
			,A.geoNodeId
			,A.criteriaId
			,A.answerType
			,A.answerCodeTxt
			,A.answerCodeScore
			,A.isLatest
			,A.isLatestByYear
		);
GO