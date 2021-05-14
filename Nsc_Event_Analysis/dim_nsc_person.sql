/****** Object:  View [dm].[view_dim_nsc_person]    Script Date: 14/05/2021 1:09:07 AM ******/
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
--drop view [dm].[view_dim_nsc_person]
CREATE VIEW [dm].[view_dim_nsc_person]
AS
(
		SELECT DISTINCT A.personId AS personId
			,ISNULL(A.externalSystemId, '') AS personExternalId
			,ISNULL(A.[personInfo.firstName], '') AS personFirstName
			,ISNULL(A.[personInfo.lastName], '') AS personLastName
			,ISNULL(A.[personInfo.firstName], '') + ' ' + ISNULL(A.[personInfo.lastName], '') AS personFullName
			,ISNULL(A.status, '') AS status
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

drop table [dm].[dim_nsc_person];

select * 
into [dm].[dim_nsc_person]
from [dm].[view_dim_nsc_person];

ALTER TABLE [dm].[dim_nsc_person] ADD CONSTRAINT dimNscPerson_pk PRIMARY KEY (personId);

select * from [dm].[dim_nsc_person];

select distinct personId from [dm].[bridge_nsc_event_to_person] where personId NOT IN (select distinct personId from  [dm].[dim_nsc_person])


---------------------------------------------------------------------------------
/****** Object:  View [dm].[view_dim_nsc_person]    Script Date: 14/05/2021 2:48:40 AM ******/
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
--drop view [dm].[view_dim_nsc_person]
CREATE VIEW [dm].[view_dim_nsc_person]
AS
(
		SELECT DISTINCT A.personId AS personId
			,ISNULL(A.externalSystemId, '') AS personExternalId
			,ISNULL(A.[personInfo.firstName], '') AS personFirstName
			,ISNULL(A.[personInfo.lastName], '') AS personLastName
			,ISNULL(A.[personInfo.firstName], '') + ' ' + ISNULL(A.[personInfo.lastName], '') AS personFullName
			,ISNULL(A.status, '') AS status
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


/****** Object:  Table [dm].[dim_person]    Script Date: 14/05/2021 2:49:45 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dm].[dim_person](
	[personId] [varchar](50) NOT NULL,
	[externalSystemId] [varchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[personInfo.firstName] [nvarchar](255) NULL,
	[personInfo.lastName] [nvarchar](255) NULL,
	[personInfo.gender] [nvarchar](50) NULL,
	[contactInfo.email] [nvarchar](100) NULL,
	[contactInfo.mobilePhone] [nvarchar](50) NULL,
	[contactInfo.fixedPhone] [nvarchar](50) NULL,
	[entityId] [varchar](50) NOT NULL,
	[primaryIndicator] [tinyint] NULL,
	[yearStartedFarming] [int] NULL,
	[educationLevel] [nvarchar](50) NULL,
	[yearsOfSchooling] [int] NULL,
	[worksWithCoffee] [nvarchar](50) NULL,
	[relationToEntity] [nvarchar](50) NULL,
	[livesAt] [nvarchar](50) NULL,
	[deliversCoffee] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[personId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


