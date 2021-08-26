/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_dim_nsc_person]    Script Date: 22/07/2021 7:40:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 26th April, 2021
 PURPOSE    : Event Analysis
 Modified By: Shubham Mishra On 13th May // Event Analysis Nescafe
 *******************************************/
--drop view [dm].[view_inc_dim_nsc_person]
CREATE VIEW [dm].[view_inc_dim_nsc_person]
AS
(
		SELECT DISTINCT A.personId AS personId
			,ISNULL(A.externalSystemId, '') AS personExternalId
			,ISNULL(A.[personInfo.firstName], '') AS personFirstName
			,ISNULL(A.[personInfo.lastName], '') AS personLastName
			,ISNULL(A.[personInfo.firstName], '') + ' ' + ISNULL(A.[personInfo.lastName], '') AS personFullName
			,ISNULL(A.STATUS, '') AS STATUS
			,ISNULL(B.label, 'N/A') AS gender
			,ISNULL(E.label, 'N/A') AS maritalStatus
			,ISNULL(D.label, 'N/A') AS educationLevel
			,ISNULL(A.[contactInfo.email], 'N/A') AS email
			,ISNULL(A.[contactInfo.mobilePhone], 'N/A') AS mobile
			,ISNULL(A.[contactInfo.fixedPhone], 'N/A') AS fixedPhone
			,ISNULL(I.entityId, 'N/A') AS personEntityId
			,ISNULL(I.externalSystemId, 'N/A') AS entityBusinessId
			,ISNULL(I.name, 'N/A') AS entityName
			,CASE 
				WHEN A.primaryIndicator = 1
					THEN 'Yes'
				ELSE 'No'
				END AS entityPrimaryContact
			,A.yearStartedFarming
			,A.yearsOfSchooling
			,ISNULL(G.label, 'N/A') AS relationToEntity
			,ISNULL(F.label, 'N/A') AS livesAt
			,ISNULL(H.label, 'N/A') AS deliversCoffee
			,ISNULL(C.label, 'N/A') AS worksWithCoffee
			,A.yearOfBirth
		FROM [dwh].[ET_Person] AS A WITH (NOLOCK)
		LEFT OUTER JOIN [dwh].[ET_Entity] AS I WITH (NOLOCK) ON A.entityId = I.entityId
		AND A.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'ET' and sqltablename = 'Person')
		INNER JOIN [dwh].[CT_GeoNode] AS J WITH (NOLOCK) ON I.geonodeId = J.geonodeId
			AND J.lineOfBusiness IN (
				'NESCAFE'
				,'GLOBAL'
				)
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
		);
GO