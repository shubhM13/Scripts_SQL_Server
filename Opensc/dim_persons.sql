SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 19th Nov, 2021
 PURPOSE    : OpenSC Model Nespresso
 *******************************************/
--drop view opensc.[view_dim_nsp_osc_persons]
CREATE VIEW [opensc].[view_dim_nsp_osc_persons]
AS
(
			SELECT distinct A.entityId
				   ,p2.[personInfo_firstName]
				   ,p2.[personInfo_lastName]
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
			FROM [dwh].[OT_Delivery] AS A
			INNER JOIN [dwh].[ET_Entity] AS Entity 
			ON A.entityId = Entity.entityId
			AND Entity.status = 'ACTIVE'
			AND A.lineOfBusiness IN (
				'NESPRESSO'
				,'GLOBAL'
				)
			INNER JOIN dm.dim_geonode_flat AS Geo ON Entity.geonodeId = Geo.geoNodeId
			AND Geo.country_name IN ('DR Congo')
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
);

drop table [opensc].[dim_nsp_osc_persons];

select *
INTO [opensc].[dim_nsp_osc_persons]
from [opensc].[view_dim_nsp_osc_persons];

ALTER TABLE [opensc].[dim_nsp_osc_persons] ALTER COLUMN entityId VARCHAR(50) NOT NULL;
ALTER TABLE [opensc].[dim_nsp_osc_persons] ADD CONSTRAINT pk_nsp_osc_persons PRIMARY KEY(entityId);

select count(*) from [opensc].[dim_nsp_osc_persons]; --2034
select count(*) from [opensc].[view_dim_nsp_osc_persons]; --2034



