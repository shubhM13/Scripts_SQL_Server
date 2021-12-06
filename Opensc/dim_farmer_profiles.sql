SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 11th Oct, 2021
 PURPOSE    : Reviving Model Nespresso
 *******************************************/
--drop view opensc.[view_dim_nsp_osc_farmer_profiles]
CREATE VIEW [opensc].[view_dim_nsp_osc_farmer_profiles]
AS
(
			SELECT AT.entityId
				  ,AT.attachmentId
				  ,AT.binaryObject
				  ,AT.mimeType
				  ,AT.fileName
				  ,AT.title
				  ,AT.fileSize
			FROM (
				SELECT distinct O.entityId 
				    ,A.attachmentId
					,A.binaryObject
					,A.mimeType
					,A.fileName
					,A.title
					,A.fileSize
					,rank() OVER (
						PARTITION BY A.owningRecordId ORDER BY A.[auditInfo.createdOn]
							,attachmentId DESC
						) AS rnk
				FROM [dwh].[OT_Delivery] AS O
				INNER JOIN [dwh].[ET_Entity] AS Entity 
				ON O.entityId = Entity.entityId
				AND Entity.status = 'ACTIVE'
				AND O.lineOfBusiness IN (
					'NESPRESSO'
					,'GLOBAL'
					)
				INNER JOIN dm.dim_geonode_flat AS Geo ON Entity.geonodeId = Geo.geoNodeId
				AND Geo.country_name IN ('DR Congo')
				LEFT JOIN [dwh].[CT_Attachment] AS A
				ON O.entityId = A.owningRecordId
				AND A.owningRecordType = 'ENTITY'
				AND A.primaryIndicator = 1
				AND A.documentType = 'PHOTO'
				) AS AT
			WHERE AT.rnk = 1
);

drop table [opensc].[dim_nsp_osc_farmer_profiles];

select *
INTO [opensc].[dim_nsp_osc_farmer_profiles]
from [opensc].[view_dim_nsp_osc_farmer_profiles];

ALTER TABLE [opensc].[dim_nsp_osc_farmer_profiles] ALTER COLUMN entityId VARCHAR(50) NOT NULL;
ALTER TABLE [opensc].[dim_nsp_osc_farmer_profiles] ADD CONSTRAINT pk_nsp_osc_farmer_profiles PRIMARY KEY(entityId);

select count(*) from [opensc].[dim_nsp_osc_farmer_profiles]; --2034
select count(*) from [opensc].[view_dim_nsp_osc_farmer_profiles]; --2034


