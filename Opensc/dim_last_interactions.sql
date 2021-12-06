SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 19th Nov, 2021
 PURPOSE    : OSC Model Nespresso
 *******************************************/
--drop view opensc.[view_dim_nsp_osc_last_interaction]
CREATE VIEW [opensc].[view_dim_nsp_osc_last_interaction]
AS
(			
			SELECT distinct A.entityId
				  ,Int.lastInteractionDate
				  ,Int.lastInteractionStatus
				  ,Int.lastInteractionType
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
			SELECT *
			FROM (
				SELECT distinct I.entityId
					,I.startDate AS lastInteractionDate
					,I.STATUS AS lastInteractionStatus
					,I.type AS lastInteractionType
					,ROW_NUMBER() OVER (
						PARTITION BY I.entityId ORDER BY I.[auditInfo.modifiedOn] DESC
						) AS rnk
				FROM [dwh].[IT_Interaction] AS I
				WHERE I.STATUS NOT IN (
						'CANCELLED'
						,'DELETED'
						,'PLANNED'
						)
				AND I.entityId IS NOT NULL
				) AS Interaction
			WHERE Interaction.rnk = 1)
			AS Int ON A.entityId = Int.entityId
);

drop table [opensc].[dim_nsp_osc_last_interaction];

select *
INTO [opensc].[dim_nsp_osc_last_interaction]
from [opensc].[view_dim_nsp_osc_last_interaction];

ALTER TABLE [opensc].[dim_nsp_osc_last_interaction] ALTER COLUMN entityId VARCHAR(50) NOT NULL;
ALTER TABLE [opensc].[dim_nsp_osc_last_interaction] ADD CONSTRAINT pk_nsp_osc_last_interaction PRIMARY KEY(entityId);

select count(*) from [opensc].[dim_nsp_osc_last_interaction]; --2034
select count(*) from [opensc].[view_dim_nsp_osc_last_interaction]; --2034


