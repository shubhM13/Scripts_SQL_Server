SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 11th Oct, 2021
 PURPOSE    : Reviving Model Nespresso
 *******************************************/
--drop view dm.[view_dim_nsp_ro_last_interaction]
CREATE VIEW [dm].[view_dim_nsp_ro_last_interaction]
AS
(			
			SELECT distinct A.entityId
				  ,Int.lastInteractionDate
				  ,Int.lastInteractionStatus
				  ,Int.lastInteractionType
			FROM [dwh].[OT_Delivery] AS A
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

drop table [aaa].[dim_nsp_ro_last_interaction];

select *
INTO [aaa].[dim_nsp_ro_last_interaction]
from [dm].[view_dim_nsp_ro_last_interaction];

ALTER TABLE [aaa].[dim_nsp_ro_last_interaction] ALTER COLUMN entityId VARCHAR(50) NOT NULL;
ALTER TABLE [aaa].[dim_nsp_ro_last_interaction] ADD CONSTRAINT pk_nsp_ro_last_interaction PRIMARY KEY(entityId);

select entityId, count(*)
from [aaa].[dim_nsp_ro_last_interaction]
group by entityId
having count(*) > 1


