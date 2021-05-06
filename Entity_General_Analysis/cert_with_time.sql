SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 26rd April, 2021
 PURPOSE    : Dim Entity Certification With Time Nespresso Dataset
 *******************************************/
--drop view dm.view_dim_nsp_certification_with_time
CREATE VIEW [dm].[view_dim_nsp_certification_with_time]
AS
(
		SELECT DISTINCT (A.certificationId) AS certificationId
			,ISNULL(B.label, '') AS certificationType
			,ISNULL(A.entityId, '') AS certificationEntityId
			,ISNULL(A.certificationNumber, '') AS certificationNumber
			,CAST(A.certificationDate AS DATE) AS certificationDate
			,H.Day AS certificationDay
			,H.Month AS certificationMonth
			,H.MonthName AS certificationMonthName
			,H.Year AS certificationYear
			,H.MonthYear AS certificationMonthYear
			,H.Quarter AS certificationQuarter
			,H.QuarterName AS certificationQuarterName
			,ISNULL(A.averageScore, '') AS certificationAverageScore
			,ISNULL(C.label, '') AS certificationStatus
			,ISNULL(E.name, '') AS certificationGroup
			,ISNULL(F.name, '') AS certificationGroupOrg
			,ISNULL(G.[personInfo.firstName], '') + ' ' + ISNULL(G.[personInfo.lastName], '') AS certifiedByName
			,ISNULL(G.[contactInfo.email], '') AS certifiedByEmail
		FROM dwh.ET_Certification AS A
		LEFT JOIN [dm].[dim_list_option] AS B WITH (NOLOCK)
			ON A.type = B.itemCode
				AND B.setId = 'CERTIFICATION_TYPE'
		LEFT JOIN [dm].[dim_list_option] AS C WITH (NOLOCK)
			ON A.STATUS = C.itemCode
				AND C.setId = 'CERTIFICATION_STATUS'
		LEFT JOIN dwh.ET_Group AS E WITH (NOLOCK)
			ON A.certificationGroup = E.groupId
		INNER JOIN [dwh].[CT_Organisation] AS F 
			ON E.organisationId = F.organisationId
			AND F.lineOfBusiness IN ('GLOBAL', 'NESPRESSO')
		LEFT JOIN [dwh].[CT_Employee] AS G
			ON G.employeeId = A.certifiedBy
		INNER JOIN dm.dim_date AS H 
			ON CAST(FORMAT(cast(A.certificationDate AS DATE), 'yyyyMMdd') AS INT) = H.DateKey
		);
GO

select * from [dm].[view_dim_nsp_certification_with_time];

DROP TABLE [dm].[dim_nsp_certification_with_time];

SELECT *
INTO [dm].[dim_nsp_certification_with_time]
FROM [dm].[view_dim_nsp_certification_with_time];

--ALTER TABLE [dm].[dim_nsp_certification_with_time] ADD CONSTRAINT dimNspCertTime_pk PRIMARY KEY (certificationId);