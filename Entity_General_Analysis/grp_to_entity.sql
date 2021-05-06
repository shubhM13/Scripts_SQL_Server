SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 29th April, 2021
 PURPOSE    : Dim Group with Entity Nespresso Dataset
 *******************************************/
--drop view dm.view_dim_nsp_Groupwithentity
CREATE VIEW [dm].[view_dim_nsp_Groupwithentity]
AS
(
		SELECT DISTINCT ISNULL(D.entityId, '') AS groupEntityId
			,ISNULL(A.groupId, '') AS groupId
			,ISNULL(A.externalSystemId, '') AS groupExternalId
			,ISNULL(A.name, '') AS groupName
			,ISNULL(C.label, '') AS groupType
			,ISNULL(A.organisationId, '') AS groupOrganisationId
			,ISNULL(B.name, '') AS groupOrgName
		FROM dwh.ET_Group AS A
		INNER JOIN [dwh].[CT_Organisation] AS E WITH (NOLOCK) ON A.organisationId = E.organisationId
			AND E.lineOfBusiness IN (
				'NESPRESSO'
				,'GLOBAL'
				)
		LEFT JOIN [dwh].[CT_Organisation] AS B ON A.organisationId = B.organisationId
		LEFT JOIN [dm].[dim_list_option] AS C ON A.type = C.itemCode
			AND C.setId = 'GROUP_TYPE'
		LEFT JOIN [dwh].[ET_GroupToEntity] AS D ON A.groupId = D.groupId
		);
GO

drop table [dm].[dim_nsp_Groupwithentity];
select * 
into [dm].[dim_nsp_Groupwithentity]
from [dm].[view_dim_nsp_Groupwithentity];

ALTER TABLE [dm].[dim_nsp_Groupwithentity] ADD CONSTRAINT dimNspGrpToEntity_pk PRIMARY KEY (groupEntityId, groupId);

