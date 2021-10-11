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
				INNER JOIN [dwh].[OT_Delivery] AS J
				ON I.entityId = J.entityId
				AND J.lineOfBusiness IN ('GLOBAL', 'NESPRESSO')
				AND I.STATUS NOT IN (
						'CANCELLED'
						,'DELETED'
						,'PLANNED'
						)
				AND J.entityId IS NOT NULL
				) AS Interaction
			WHERE Interaction.rnk = 1
);

drop table [dm].[dim_nsp_ro_last_interaction];

select *
INTO [dm].[dim_nsp_ro_last_interaction]
from [dm].[view_dim_nsp_ro_last_interaction];

ALTER TABLE [dm].[dim_nsp_ro_last_interaction] ALTER COLUMN entityId VARCHAR(50) NOT NULL;
ALTER TABLE [dm].[dim_nsp_ro_last_interaction] ADD CONSTRAINT pk_nsp_ro_last_interaction PRIMARY KEY(entityId);

select entityId, count(*)
from [dm].[dim_nsp_ro_last_interaction]
group by entityId
having count(*) > 1


