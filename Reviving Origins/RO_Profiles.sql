SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 11th Oct, 2021
 PURPOSE    : Reviving Model Nespresso
 *******************************************/
--drop view dm.[view_dim_nsp_ro_farmer_profiles]
CREATE VIEW [dm].[view_dim_nsp_ro_farmer_profiles]
AS
(
			SELECT *
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
				LEFT JOIN [dwh].[CT_Attachment] AS A
				ON O.entityId = A.owningRecordId
				AND A.owningRecordType = 'ENTITY'
				AND A.primaryIndicator = 1
				AND A.documentType = 'PHOTO'
				) AS AT
			WHERE AT.rnk = 1
);

drop table [aaa].[dim_nsp_ro_farmer_profiles];

select *
INTO [aaa].[dim_nsp_ro_farmer_profiles]
from [dm].[view_dim_nsp_ro_farmer_profiles];

ALTER TABLE [aaa].[dim_nsp_ro_farmer_profiles] ALTER COLUMN entityId VARCHAR(50) NOT NULL;
ALTER TABLE [aaa].[dim_nsp_ro_farmer_profiles] ADD CONSTRAINT pk_nsp_ro_farmer_profiles PRIMARY KEY(entityId);

select * from [aaa].[dim_nsp_ro_farmer_profiles];



