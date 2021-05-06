SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 26th April, 2021
 PURPOSE    : Dim Person Nespresso Dataset
 *******************************************/
--drop view [dm].[view_dim_nsp_person]
CREATE VIEW [dm].[view_dim_nsp_person]
AS
(
		SELECT (A.personId)
			,ISNULL(A.externalSystemId, '') AS personExternalId
			,ISNULL(A.[personInfo.firstName], '') AS personFirstName
			,ISNULL(A.[personInfo.lastName], '') AS personLastName
			,ISNULL(A.[personInfo.firstName], '') + ' ' + ISNULL(A.[personInfo.lastName], '') AS personFullName
			,ISNULL(B.label, '') AS gender
			,ISNULL(E.label, '') AS maritalStatus
			,ISNULL(D.label, '') AS educationLevel
			,ISNULL(A.[contactInfo.email], '') AS email
			,ISNULL(A.[contactInfo.mobilePhone], '') AS mobile
			,ISNULL(A.[contactInfo.fixedPhone], '') AS fixedPhone
			,I.entityId AS personEntityId
			,I.externalSystemId AS entityBusinessId
			,I.name AS entityName
			,CASE
				WHEN A.primaryIndicator = 1
				THEN 'Yes'
				ELSE 'No'
			 END AS entityPrimaryContact
			,A.yearStartedFarming
			,A.yearsOfSchooling
			,ISNULL(G.label, '') AS relationToEntity
			,ISNULL(F.label, '') AS livesAt
			,ISNULL(H.label, '') AS deliversCoffee
			,ISNULL(C.label, '') AS worksWithCoffee
			,A.yearOfBirth
		FROM [dwh].[ET_Person] AS A WITH (NOLOCK)
		LEFT OUTER JOIN [dm].[dim_list_option] AS B WITH (NOLOCK) ON A.[personInfo.gender] = B.itemCode
			AND B.setid = 'GENDER'
		LEFT OUTER JOIN [dm].[dim_list_option] AS C WITH (NOLOCK) ON A.worksWithCoffee = C.itemCode
			AND C.setid = 'COFFEE_RELATION'
		LEFT OUTER JOIN [dm].[dim_list_option] AS D WITH (NOLOCK) ON A.educationLevel = D.itemCode
			AND D.setid = 'EDUCATION_LEVEL'
		LEFT OUTER JOIN [dm].[dim_list_option] AS E WITH (NOLOCK) ON A.[personInfo.maritalStatus] = E.itemCode
			AND E.setid = 'MARITAL_STATUS'
		LEFT OUTER JOIN [dm].[dim_list_option] AS F WITH (NOLOCK) ON A.livesAt = F.itemCode
			AND F.setid = 'FARM_DOMICILE_IND'
		LEFT OUTER JOIN [dm].[dim_list_option] AS G WITH (NOLOCK) ON A.relationToEntity = G.itemCode
			AND G.setid = 'ENTITY_RELATION'
		LEFT OUTER JOIN [dm].[dim_list_option] AS H WITH (NOLOCK) ON A.deliversCoffee = H.itemCode
			AND H.setid = 'PERSON_DELIVERS_COFFEE'
		LEFT OUTER JOIN [dwh].[ET_Entity] AS I WITH (NOLOCK) ON A.entityId = I.entityId
		INNER JOIN [dwh].[CT_GeoNode] AS J WITH (NOLOCK) ON I.geonodeId = J.geonodeId
			AND J.lineOfBusiness IN (
				'NESPRESSO'
				,'GLOBAL'
				)
		Where A.status = 'ACTIVE'
		);

drop table [dm].[dim_nsp_person];

select * 
into [dm].[dim_nsp_person]
from [dm].[view_dim_nsp_person];

ALTER TABLE [dm].[dim_nsp_person] ADD CONSTRAINT dimNspPerson_pk PRIMARY KEY (personId);

select * from [dm].[dim_nsp_person];

