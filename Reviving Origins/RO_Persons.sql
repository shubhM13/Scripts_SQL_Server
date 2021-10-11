SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 11th Oct, 2021
 PURPOSE    : Reviving Model Nespresso
 *******************************************/
--drop view dm.[view_dim_nsp_ro_persons]
CREATE VIEW [dm].[view_dim_nsp_ro_persons]
AS
(
			SELECT *
			FROM (
				SELECT P1.entityId 
				    ,P1.[personInfo.firstName] AS [personInfo_firstName]
					,P1.[personInfo.lastName] AS [personInfo_lastName]
					,P1.primaryIndicator
					,P1.ExternalSystemId AS personExternalSystemId
					,P1.[personInfo.gender] AS personInfo_gender
					,P1.relationToEntity
					,P1.yearOfBirth
					,P1.yearStartedFarming
					,P1.yearsOfSchooling
					,P1.educationLevel
					,P1.worksWithCoffee
					,P1.[personInfo.maritalStatus] AS personInfo_maritalStatus
					,P1.livesAt
					,ROW_NUMBER() OVER (
						PARTITION BY P1.entityId ORDER BY P1.[auditInfo.modifiedOn] DESC
						) AS rnk
				FROM [dwh].[OT_Delivery] AS O
				INNER JOIN dwh.[ET_Person] AS P1 
				ON O.entityId = P1.entityId
				AND O.lineOfBusiness IN ('GLOBAL', 'NESPRESSO')
				AND P1.STATUS = 'ACTIVE'
				AND P1.primaryIndicator = 1
				) AS p2
			WHERE p2.rnk = 1
);

drop table [dm].[dim_nsp_ro_persons];

select *
INTO [dm].[dim_nsp_ro_persons]
from [dm].[view_dim_nsp_ro_persons];

ALTER TABLE [dm].[dim_nsp_ro_persons] ALTER COLUMN entityId VARCHAR(50) NOT NULL;
ALTER TABLE [dm].[dim_nsp_ro_persons] ADD CONSTRAINT pk_nsp_ro_persons PRIMARY KEY(entityId);

select * from [dm].[dim_nsp_ro_persons];



