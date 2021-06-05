------------------------------------------------------------------------------------------------------------

/*******************************************
 Author     : Shubham Mishra
 Created On : 20th May, 2021
 PURPOSE    : 4C Assessments
 *******************************************/
--drop view dm.view_dim_nsc_4C_group
CREATE VIEW dm.view_dim_nsc_4C_group
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
		INNER JOIN [dwh].[ET_Group] AS R ON Q.certificationGroup = R.groupId
			AND R.type = 'CERTIFICATION'
			AND R.certificationType = '4C'
			AND Q.certificationExpiryDate > GETDATE()
		);

DROP TABLE dm.dim_nsc_4C_group;

SELECT *
INTO dm.dim_nsc_4C_group
FROM dm.view_dim_nsc_4C_group;

ALTER TABLE dm.dim_nsc_4C_group ADD CONSTRAINT dimNsc4C PRIMARY KEY (
	entityId
	,entityCertId
	);
