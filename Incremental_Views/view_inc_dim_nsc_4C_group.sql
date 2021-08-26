/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_dim_nsc_4C_group]    Script Date: 22/07/2021 10:31:15 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 20th May, 2021
 PURPOSE    : 4C Assessments
 *******************************************/
--drop view dm.view_inc_dim_nsc_4C_group
CREATE VIEW [dm].[view_inc_dim_nsc_4C_group]
AS
(
		SELECT DISTINCT P.entityId
			,Q.certificationId AS entityCertId
			,ISNULL(Q.certificationNumber, 'N/A') AS entityCertNumber
			,Q.certificationDate AS entityCertDate
			,ISNULL(Q.STATUS, 'N/A') AS entityCertStatus
			,Q.averageScore AS entityCertAvgScore
			,Q.certifiedBy AS entityCertifiedBy
			,ISNULL(R.groupId, 'N/A') AS groupId
			,R.STATUS AS grpStatus
			,ISNULL(R.name, 'N/A') AS groupName
			,ISNULL(R.certificationNumber, 'N/A') AS grpCertNumber
			,R.certificationDate AS grpCertDate
			,ISNULL(R.certificationStatus, 'N/A') AS grpCertStatus
			,R.certificationAvgScore AS grpCertAvgScore
			,R.certifiedBy AS grpCertifiedBy
		FROM dwh.ET_Entity AS P
		INNER JOIN [dwh].[ET_Certification] AS Q ON P.entityId = Q.entityId
		AND P.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'ET' and sqltablename = 'Entity')
		INNER JOIN [dwh].[ET_Group] AS R ON Q.certificationGroup = R.groupId
			AND R.type = 'CERTIFICATION'
			AND R.certificationType = '4C'
			AND Q.certificationExpiryDate > GETDATE()
		);
GO