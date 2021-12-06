SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 26th Oct, 2021
 PURPOSE    : Regen Ag Model
 *******************************************/
--drop view dm.[view_dim_entity_primary_contact]
ALTER VIEW [dm].[view_dim_entity_primary_contact]
AS
(
			SELECT distinct A.entityId
				   ,p2.[personInfo_firstName] AS firstName
				   ,p2.[personInfo_lastName] AS lastName
				   ,p2.personExternalSystemId
				   ,p2.personInfo_gender
				   ,p2.relationToEntity
				   ,p2.yearOfBirth
				   ,p2.yearStartedFarming
				   ,p2.yearsOfSchooling
				   ,p2.educationLevel
				   ,p2.worksWithCoffee
				   ,p2.personInfo_maritalStatus
				   ,p2.livesAt
			FROM [dwh].[ET_Entity] AS A 
			LEFT JOIN (
			select * from(
				SELECT P1.entityId 
				    ,P1.[personInfo.firstName] AS [personInfo_firstName]
					,P1.[personInfo.lastName] AS [personInfo_lastName]
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
				FROM dwh.[ET_Person] AS P1 
				WHERE P1.STATUS = 'ACTIVE'
				AND P1.primaryIndicator = 1
				) AS Persons
			WHERE Persons.rnk = 1) AS p2
			ON A.entityId = p2.entityId	
			AND A.status = 'ACTIVE'
);

drop table [dm].[dim_entity_primary_contact];

select *
INTO [dm].[dim_entity_primary_contact]
from [dm].[view_dim_entity_primary_contact];

ALTER TABLE [dm].[dim_entity_primary_contact] ALTER COLUMN entityId VARCHAR(50) NOT NULL;
ALTER TABLE [dm].[dim_entity_primary_contact] ADD CONSTRAINT pk_primary_contact_persons PRIMARY KEY(entityId);

select count(*) from [dm].[dim_entity_primary_contact]; --2034
select count(*) from [dm].[view_dim_entity_primary_contact]; --2034



