/****** Object:  Table [AT].[DM_Observation]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [AT].[DM_Observation](
	[observationId] [varchar](50) NOT NULL,
	[status] [nvarchar](50) NULL,
	[type] [nvarchar](50) NULL,
	[obsDateTime] [datetime2](0) NULL,
	[entityId] [varchar](50) NULL,
	[criteriaId] [varchar](50) NOT NULL,
	[interactionId] [varchar](50) NOT NULL,
	[parentObservationId] [varchar](50) NULL,
	[notApplicableFlag] [tinyint] NULL,
	[riskyFlag] [tinyint] NULL,
	[answerType] [nvarchar](50) NULL,
	[answerDate] [datetime2](0) NULL,
	[answerDate2] [datetime2](0) NULL,
	[answerText] [nvarchar](max) NULL,
	[answerNumber] [float] NULL,
	[unitOfMeasure] [nvarchar](50) NULL,
	[currencyCode] [nvarchar](50) NULL,
	[comments] [nvarchar](max) NULL,
	[correctiveActions] [nvarchar](max) NULL,
	[notes] [nvarchar](max) NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime2](7) NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime2](7) NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[answerCode] [nvarchar](50) NULL,
	[isLatest] [tinyint] NULL,
	[isLatestByYear] [tinyint] NULL,
	[obsDateOnly] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[observationId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [AT].[STG_Observation]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [AT].[STG_Observation](
	[observationId] [varchar](50) NOT NULL,
	[status] [nvarchar](50) NULL,
	[type] [nvarchar](50) NULL,
	[obsDateTime] [datetime2](0) NULL,
	[entityId] [varchar](50) NULL,
	[criteriaId] [varchar](50) NOT NULL,
	[interactionId] [varchar](50) NOT NULL,
	[parentObservationId] [varchar](50) NULL,
	[notApplicableFlag] [tinyint] NULL,
	[riskyFlag] [tinyint] NULL,
	[answerType] [nvarchar](50) NULL,
	[answerDate] [datetime2](0) NULL,
	[answerDate2] [datetime2](0) NULL,
	[answerText] [nvarchar](max) NULL,
	[answerNumber] [float] NULL,
	[unitOfMeasure] [nvarchar](50) NULL,
	[currencyCode] [nvarchar](50) NULL,
	[comments] [nvarchar](max) NULL,
	[correctiveActions] [nvarchar](max) NULL,
	[notes] [nvarchar](max) NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime2](7) NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime2](7) NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[answerCode] [nvarchar](50) NULL,
	[isLatest] [tinyint] NULL,
	[isLatestByYear] [tinyint] NULL,
	[obsDateOnly] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[observationId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [AUDIT].[CONTROL_TABLE]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [AUDIT].[CONTROL_TABLE](
	[TABLE_SCHEMA] [varchar](100) NULL,
	[TABLE_NAME] [varchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [CT].[DM_GeoNode]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CT].[DM_GeoNode](
	[geoNodeId] [varchar](50) NOT NULL,
	[geoNodeType] [nvarchar](50) NOT NULL,
	[parentId] [varchar](50) NULL,
	[isLeaf] [tinyint] NULL,
	[status] [nvarchar](50) NOT NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime] NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime] NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[activationDate] [datetime] NULL,
	[name] [nvarchar](255) NOT NULL,
	[countryCode] [nvarchar](50) NULL,
	[currencyCode] [nvarchar](50) NULL,
	[lineOfBusiness] [nvarchar](50) NULL,
	[shape] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[geoNodeId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [CT].[STG_GeoNode]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [CT].[STG_GeoNode](
	[geoNodeId] [varchar](50) NOT NULL,
	[geoNodeType] [nvarchar](50) NOT NULL,
	[parentId] [varchar](50) NULL,
	[isLeaf] [tinyint] NULL,
	[status] [nvarchar](50) NOT NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime] NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime] NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[activationDate] [datetime] NULL,
	[name] [nvarchar](255) NOT NULL,
	[countryCode] [nvarchar](50) NULL,
	[currencyCode] [nvarchar](50) NULL,
	[lineOfBusiness] [nvarchar](50) NULL,
	[shape] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[geoNodeId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[sysdiagrams]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[sysdiagrams](
	[name] [sysname] NOT NULL,
	[principal_id] [int] NOT NULL,
	[diagram_id] [int] IDENTITY(1,1) NOT NULL,
	[version] [int] NULL,
	[definition] [varbinary](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[diagram_id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UK_principal_name] UNIQUE NONCLUSTERED 
(
	[principal_id] ASC,
	[name] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dm].[dim_date]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dm].[dim_date](
	[date_key] [int] NOT NULL,
 CONSTRAINT [PK_dim_date] PRIMARY KEY CLUSTERED 
(
	[date_key] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dm].[dim_entity]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dm].[dim_entity](
	[entityId] [varchar](50) NOT NULL,
	[isValidCoordinates] [nchar](10) NULL,
	[locationVerified] [tinyint] NULL,
	[license4C] [nchar](10) NULL,
	[4cUnit] [nchar](10) NULL,
	[externalSystemId] [varchar](50) NULL,
	[entityType] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[name] [nvarchar](255) NULL,
	[Coordinates_longX] [float] NULL,
	[Coordinates_latY] [float] NULL,
	[altZ] [float] NULL,
	[nestleOwned] [tinyint] NULL,
	[ownershipType] [nvarchar](50) NULL,
	[foundationYear] [varchar](50) NULL,
	[AAAEntryYear] [varchar](50) NULL,
	[relationshipDate] [datetime2](0) NULL,
	[nurseryOnSite] [tinyint] NULL,
	[millOnSite] [tinyint] NULL,
	[isPartOfAgripreneurship] [nvarchar](50) NULL,
	[geoNodeId] [varchar](50) NULL,
	[SubClusterName] [nvarchar](255) NULL,
	[ClusterName] [nvarchar](255) NULL,
	[CountryName] [nvarchar](255) NULL,
	[entityStatusTxt] [nvarchar](100) NULL,
	[entityTypeTxt] [nvarchar](100) NULL,
	[ownershipTypeTxt] [nvarchar](100) NULL,
	[status4CTxt] [nvarchar](100) NULL,
 CONSTRAINT [PK_dim_entity] PRIMARY KEY CLUSTERED 
(
	[entityId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dm].[dim_geonode_flat]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dm].[dim_geonode_flat](
	[geoNodeId] [varchar](50) NOT NULL,
	[type] [nvarchar](50) NULL,
	[sub_cluster] [varchar](50) NULL,
	[sub_cluster_name] [nvarchar](255) NULL,
	[sub_cluster_status] [nvarchar](50) NULL,
	[cluster] [varchar](50) NULL,
	[cluster_name] [nvarchar](255) NULL,
	[cluster_status] [nvarchar](50) NULL,
	[cluster_lob] [nvarchar](50) NULL,
	[country] [varchar](50) NULL,
	[country_name] [nvarchar](255) NULL,
	[country_status] [nvarchar](50) NULL,
	[countryCode] [nvarchar](50) NULL,
	[currencyCode] [nvarchar](50) NULL,
 CONSTRAINT [PK_dim_geonode_flat] PRIMARY KEY CLUSTERED 
(
	[geoNodeId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dm].[dim_variety]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dm].[dim_variety](
	[varietyId] [varchar](50) NOT NULL,
	[name] [nvarchar](255) NULL,
	[referenceNumber] [nvarchar](50) NULL,
	[genericFlag] [tinyint] NULL,
	[status] [nvarchar](50) NULL,
	[species] [nvarchar](50) NULL,
	[origin] [nvarchar](50) NULL,
	[genericStatus] [nvarchar](50) NULL,
	[arabicaShape] [nvarchar](50) NULL,
	[molecularSignature] [tinyint] NULL,
	[organisationId] [varchar](50) NOT NULL,
	[parents] [nvarchar](255) NULL,
	[propMethod] [nvarchar](50) NULL,
	[countryOfOrigin] [varchar](50) NULL,
 CONSTRAINT [PK_dim_variety] PRIMARY KEY CLUSTERED 
(
	[varietyId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dm].[fact_nsc_plantlet_asssesment]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dm].[fact_nsc_plantlet_asssesment](
	[observationId] [varchar](50) NOT NULL,
	[obsDateTime] [datetime2](7) NULL,
	[entityId] [varchar](50) NULL,
	[interactionId] [varchar](50) NOT NULL,
	[parentObservationId] [varchar](50) NULL,
	[answerType] [nchar](10) NULL,
	[answerDate] [datetime2](0) NULL,
	[answerDate2] [datetime2](7) NULL,
	[answerText] [nvarchar](max) NULL,
	[answerNumber] [float] NULL,
	[answerCode] [nvarchar](50) NULL,
	[obsDateOnly] [date] NULL,
 CONSTRAINT [PK_fact_nsc_plantlet_asssesment] PRIMARY KEY CLUSTERED 
(
	[observationId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dm].[fact_nsc_plantlet_distribution]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dm].[fact_nsc_plantlet_distribution](
	[movementId] [varchar](50) NOT NULL,
	[type] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[varietyId] [varchar](50) NULL,
	[propagationMethod] [nvarchar](50) NULL,
	[shipmentIdentifier] [nvarchar](255) NULL,
	[startEntityId] [varchar](50) NOT NULL,
	[startGeoNodeId] [varchar](50) NULL,
	[endEntityId] [varchar](50) NOT NULL,
	[endGeoNodeId] [varchar](50) NULL,
	[senderId] [varchar](50) NULL,
	[sentOn] [datetime2](7) NULL,
	[sentQty] [int] NULL,
	[receiverId] [varchar](50) NULL,
	[receivedOn] [datetime2](7) NULL,
	[receivedQty] [int] NULL,
	[price.amount] [varchar](50) NULL,
	[price.currencyCode] [nvarchar](50) NULL,
	[costOfProduction.amount] [varchar](50) NULL,
	[costOfProduction.currencyCode] [nvarchar](50) NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime2](7) NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime2](7) NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[lossReason] [nvarchar](50) NULL,
	[distributionPurpose] [nvarchar](50) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dwh].[AT_Observation]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dwh].[AT_Observation](
	[observationId] [varchar](50) NOT NULL,
	[status] [nvarchar](50) NULL,
	[type] [nvarchar](50) NULL,
	[obsDateTime] [datetime2](0) NULL,
	[entityId] [varchar](50) NULL,
	[criteriaId] [varchar](50) NOT NULL,
	[interactionId] [varchar](50) NOT NULL,
	[parentObservationId] [varchar](50) NULL,
	[notApplicableFlag] [tinyint] NULL,
	[riskyFlag] [tinyint] NULL,
	[answerType] [nvarchar](50) NULL,
	[answerDate] [datetime2](0) NULL,
	[answerDate2] [datetime2](0) NULL,
	[answerText] [nvarchar](max) NULL,
	[answerNumber] [float] NULL,
	[unitOfMeasure] [nvarchar](50) NULL,
	[currencyCode] [nvarchar](50) NULL,
	[comments] [nvarchar](max) NULL,
	[correctiveActions] [nvarchar](max) NULL,
	[notes] [nvarchar](max) NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime2](7) NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime2](7) NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[answerCode] [nvarchar](50) NULL,
	[isLatest] [tinyint] NULL,
	[isLatestByYear] [tinyint] NULL,
	[obsDateOnly] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[observationId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dwh].[CT_GeoNode]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dwh].[CT_GeoNode](
	[geoNodeId] [varchar](50) NOT NULL,
	[geoNodeType] [nvarchar](50) NOT NULL,
	[parentId] [varchar](50) NULL,
	[isLeaf] [tinyint] NULL,
	[status] [nvarchar](50) NOT NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime] NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime] NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[activationDate] [datetime] NULL,
	[name] [nvarchar](255) NOT NULL,
	[countryCode] [nvarchar](50) NULL,
	[currencyCode] [nvarchar](50) NULL,
	[lineOfBusiness] [nvarchar](50) NULL,
	[shape] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[geoNodeId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dwh].[ET_Entity]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dwh].[ET_Entity](
	[entityId] [varchar](50) NOT NULL,
	[externalSystemId] [varchar](50) NULL,
	[entityType] [nvarchar](50) NOT NULL,
	[status] [nvarchar](50) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[coordinates.longX] [float] NULL,
	[coordinates.latY] [float] NULL,
	[altZ] [float] NULL,
	[nestleOwned] [tinyint] NULL,
	[ownershipType] [nvarchar](50) NULL,
	[geoNodeId] [varchar](50) NULL,
	[foundationYear] [int] NULL,
	[AAAEntryYear] [int] NULL,
	[relationshipDate] [datetime] NULL,
	[nurseryOnSite] [tinyint] NULL,
	[millOnSite] [tinyint] NULL,
	[displayPermissionOK] [tinyint] NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime] NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime] NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[addressInfo.address1] [nvarchar](255) NULL,
	[addressInfo.address2] [nvarchar](255) NULL,
	[addressInfo.city] [nvarchar](255) NULL,
	[addressInfo.district] [nvarchar](255) NULL,
	[addressInfo.province] [nvarchar](255) NULL,
	[addressInfo.zipcode] [nvarchar](255) NULL,
	[addressInfo.countryCode] [nvarchar](50) NULL,
	[locationVerified] [tinyint] NULL,
	[geoStatus] [nvarchar](50) NULL,
	[inactivatedOn] [datetime] NULL,
	[AAAEnrolmentDate] [datetime] NULL,
	[AAAStatus] [nvarchar](50) NULL,
	[4CStatus] [nvarchar](50) NULL,
	[openQuantity] [int] NULL,
	[registrationNo] [nvarchar](50) NULL,
	[managingEntity] [nvarchar](255) NULL,
	[mainActivity] [nvarchar](50) NULL,
	[verificationType] [nvarchar](50) NULL,
	[completionDate] [datetime] NULL,
	[isPartOfAgripreneurship] [nvarchar](50) NULL,
	[subEntityType] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[entityId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dwh].[IT_Interaction]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dwh].[IT_Interaction](
	[interactionId] [varchar](50) NOT NULL,
	[type] [nvarchar](50) NULL,
	[name] [nvarchar](255) NULL,
	[notes] [nvarchar](4000) NULL,
	[location] [nvarchar](4000) NULL,
	[status] [nvarchar](50) NULL,
	[entityId] [varchar](50) NULL,
	[employeeId] [varchar](50) NULL,
	[eventId] [varchar](50) NULL,
	[varietyTrialId] [varchar](50) NULL,
	[siteTrialId] [varchar](50) NULL,
	[personId] [varchar](50) NULL,
	[templateId] [varchar](50) NULL,
	[startDate] [datetime] NULL,
	[endDate] [datetime] NULL,
	[geoNodeId] [varchar](50) NULL,
	[organisationId] [varchar](50) NOT NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime2](7) NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime2](7) NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[correctiveActions] [nvarchar](4000) NULL,
	[movementId] [varchar](50) NULL,
	[transactionId] [varchar](50) NULL,
	[startDateOnly] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[interactionId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dwh].[PT_Movement]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dwh].[PT_Movement](
	[movementId] [varchar](50) NOT NULL,
	[type] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[varietyId] [varchar](50) NULL,
	[propagationMethod] [nvarchar](50) NULL,
	[shipmentIdentifier] [nvarchar](255) NULL,
	[startEntityId] [varchar](50) NOT NULL,
	[endEntityId] [varchar](50) NOT NULL,
	[senderId] [varchar](50) NULL,
	[sentOn] [datetime] NULL,
	[sentQty] [int] NULL,
	[receiverId] [varchar](50) NULL,
	[receivedOn] [datetime] NULL,
	[receivedQty] [int] NULL,
	[price.amount] [varchar](50) NULL,
	[price.currencyCode] [nvarchar](50) NULL,
	[costOfProduction.amount] [varchar](50) NULL,
	[costOfProduction.currencyCode] [nvarchar](50) NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime] NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime] NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[lossReason] [nvarchar](50) NULL,
	[distributionPurpose] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[movementId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dwh].[PT_Variety]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dwh].[PT_Variety](
	[varietyId] [varchar](50) NOT NULL,
	[name] [nvarchar](255) NULL,
	[referenceNumber] [nvarchar](50) NULL,
	[genericFlag] [tinyint] NULL,
	[genericVarietyId] [varchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[species] [nvarchar](50) NULL,
	[origin] [nvarchar](50) NULL,
	[countryOfOrigin] [varchar](50) NULL,
	[geneticStatus] [nvarchar](50) NULL,
	[arabicaShape] [nvarchar](50) NULL,
	[molecularSignature] [tinyint] NULL,
	[organisationId] [varchar](50) NOT NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime] NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime] NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[parents] [nvarchar](255) NULL,
	[propMethod] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[varietyId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [ET].[DM_Entity]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ET].[DM_Entity](
	[entityId] [varchar](50) NOT NULL,
	[externalSystemId] [varchar](50) NULL,
	[entityType] [nvarchar](50) NOT NULL,
	[status] [nvarchar](50) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[coordinates.longX] [float] NULL,
	[coordinates.latY] [float] NULL,
	[altZ] [varchar](50) NULL,
	[nestleOwned] [tinyint] NULL,
	[ownershipType] [nvarchar](50) NULL,
	[geoNodeId] [varchar](50) NULL,
	[foundationYear] [varchar](50) NULL,
	[AAAEntryYear] [varchar](50) NULL,
	[relationshipDate] [varchar](50) NULL,
	[nurseryOnSite] [varchar](50) NULL,
	[millOnSite] [tinyint] NULL,
	[displayPermissionOK] [tinyint] NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime] NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [varchar](50) NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[addressInfo.address1] [nvarchar](255) NULL,
	[addressInfo.address2] [nvarchar](255) NULL,
	[addressInfo.city] [nvarchar](255) NULL,
	[addressInfo.district] [nvarchar](255) NULL,
	[addressInfo.province] [nvarchar](255) NULL,
	[addressInfo.zipcode] [nvarchar](255) NULL,
	[addressInfo.countryCode] [nvarchar](50) NULL,
	[locationVerified] [tinyint] NULL,
	[geoStatus] [nvarchar](50) NULL,
	[inactivatedOn] [datetime] NULL,
	[AAAEnrolmentDate] [datetime] NULL,
	[AAAStatus] [nvarchar](50) NULL,
	[4CStatus] [nvarchar](50) NULL,
	[openQuantity] [int] NULL,
	[registrationNo] [nvarchar](50) NULL,
	[managingEntity] [nvarchar](255) NULL,
	[mainActivity] [nvarchar](50) NULL,
	[verificationType] [nvarchar](50) NULL,
	[completionDate] [datetime] NULL,
	[isPartOfAgripreneurship] [nvarchar](50) NULL,
	[subEntityType] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[entityId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [ET].[STG_Entity]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [ET].[STG_Entity](
	[entityId] [varchar](50) NOT NULL,
	[externalSystemId] [varchar](50) NULL,
	[entityType] [nvarchar](50) NOT NULL,
	[status] [nvarchar](50) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[coordinates.longX] [float] NULL,
	[coordinates.latY] [float] NULL,
	[altZ] [varchar](50) NULL,
	[nestleOwned] [tinyint] NULL,
	[ownershipType] [nvarchar](50) NULL,
	[geoNodeId] [varchar](50) NULL,
	[foundationYear] [varchar](50) NULL,
	[AAAEntryYear] [varchar](50) NULL,
	[relationshipDate] [varchar](50) NULL,
	[nurseryOnSite] [varchar](50) NULL,
	[millOnSite] [tinyint] NULL,
	[displayPermissionOK] [tinyint] NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime] NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [varchar](50) NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[addressInfo.address1] [nvarchar](255) NULL,
	[addressInfo.address2] [nvarchar](255) NULL,
	[addressInfo.city] [nvarchar](255) NULL,
	[addressInfo.district] [nvarchar](255) NULL,
	[addressInfo.province] [nvarchar](255) NULL,
	[addressInfo.zipcode] [nvarchar](255) NULL,
	[addressInfo.countryCode] [nvarchar](50) NULL,
	[locationVerified] [tinyint] NULL,
	[geoStatus] [nvarchar](50) NULL,
	[inactivatedOn] [datetime] NULL,
	[AAAEnrolmentDate] [datetime] NULL,
	[AAAStatus] [nvarchar](50) NULL,
	[4CStatus] [nvarchar](50) NULL,
	[openQuantity] [int] NULL,
	[registrationNo] [nvarchar](50) NULL,
	[managingEntity] [nvarchar](255) NULL,
	[mainActivity] [nvarchar](50) NULL,
	[verificationType] [nvarchar](50) NULL,
	[completionDate] [datetime] NULL,
	[isPartOfAgripreneurship] [nvarchar](50) NULL,
	[subEntityType] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[entityId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[DM_Interaction]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[DM_Interaction](
	[interactionId] [varchar](50) NOT NULL,
	[type] [nvarchar](50) NULL,
	[name] [nvarchar](255) NULL,
	[notes] [nvarchar](4000) NULL,
	[location] [nvarchar](4000) NULL,
	[status] [nvarchar](50) NULL,
	[entityId] [varchar](50) NULL,
	[employeeId] [varchar](50) NULL,
	[eventId] [varchar](50) NULL,
	[varietyTrialId] [varchar](50) NULL,
	[siteTrialId] [varchar](50) NULL,
	[personId] [varchar](50) NULL,
	[templateId] [varchar](50) NULL,
	[startDate] [datetime] NULL,
	[endDate] [datetime] NULL,
	[geoNodeId] [varchar](50) NULL,
	[organisationId] [varchar](50) NOT NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime2](7) NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime2](7) NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[correctiveActions] [nvarchar](4000) NULL,
	[movementId] [varchar](50) NULL,
	[transactionId] [varchar](50) NULL,
	[startDateOnly] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[interactionId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [IT].[STG_Interaction]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [IT].[STG_Interaction](
	[interactionId] [varchar](50) NOT NULL,
	[type] [varchar](50) NULL,
	[name] [varchar](255) NULL,
	[notes] [varchar](4000) NULL,
	[location] [varchar](4000) NULL,
	[status] [varchar](50) NULL,
	[entityId] [varchar](50) NULL,
	[employeeId] [varchar](50) NULL,
	[eventId] [varchar](50) NULL,
	[varietyTrialId] [varchar](50) NULL,
	[siteTrialId] [varchar](50) NULL,
	[personId] [varchar](50) NULL,
	[templateId] [varchar](50) NULL,
	[startDate] [varchar](50) NULL,
	[endDate] [varchar](50) NULL,
	[geoNodeId] [varchar](50) NULL,
	[organisationId] [varchar](50) NOT NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [varchar](50) NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [varchar](50) NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [varchar](50) NULL,
	[auditInfo.channel] [varchar](50) NULL,
	[correctiveActions] [varchar](4000) NULL,
	[movementId] [varchar](50) NULL,
	[transactionId] [varchar](50) NULL,
	[startDateOnly] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[interactionId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PT].[DM_Movement]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PT].[DM_Movement](
	[movementId] [varchar](50) NOT NULL,
	[type] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[varietyId] [varchar](50) NULL,
	[propagationMethod] [nvarchar](50) NULL,
	[shipmentIdentifier] [nvarchar](255) NULL,
	[startEntityId] [varchar](50) NOT NULL,
	[endEntityId] [varchar](50) NOT NULL,
	[senderId] [varchar](50) NULL,
	[sentOn] [varchar](50) NULL,
	[sentQty] [int] NULL,
	[receiverId] [varchar](50) NULL,
	[receivedOn] [varchar](50) NULL,
	[receivedQty] [int] NULL,
	[price.amount] [varchar](50) NULL,
	[price.currencyCode] [nvarchar](50) NULL,
	[costOfProduction.amount] [varchar](50) NULL,
	[costOfProduction.currencyCode] [nvarchar](50) NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [varchar](50) NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [varchar](50) NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[lossReason] [nvarchar](50) NULL,
	[distributionPurpose] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[movementId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PT].[DM_Variety]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PT].[DM_Variety](
	[varietyId] [varchar](50) NOT NULL,
	[name] [nvarchar](255) NULL,
	[referenceNumber] [nvarchar](50) NULL,
	[genericFlag] [tinyint] NULL,
	[genericVarietyId] [varchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[species] [nvarchar](50) NULL,
	[origin] [nvarchar](50) NULL,
	[countryOfOrigin] [varchar](50) NULL,
	[geneticStatus] [nvarchar](50) NULL,
	[arabicaShape] [nvarchar](50) NULL,
	[molecularSignature] [tinyint] NULL,
	[organisationId] [varchar](50) NOT NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime] NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime] NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[parents] [nvarchar](255) NULL,
	[propMethod] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[varietyId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PT].[STG_Movement]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PT].[STG_Movement](
	[movementId] [varchar](50) NOT NULL,
	[type] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[varietyId] [varchar](50) NULL,
	[propagationMethod] [nvarchar](50) NULL,
	[shipmentIdentifier] [nvarchar](255) NULL,
	[startEntityId] [varchar](50) NOT NULL,
	[endEntityId] [varchar](50) NOT NULL,
	[senderId] [varchar](50) NULL,
	[sentOn] [varchar](50) NULL,
	[sentQty] [int] NULL,
	[receiverId] [varchar](50) NULL,
	[receivedOn] [varchar](50) NULL,
	[receivedQty] [int] NULL,
	[price.amount] [varchar](50) NULL,
	[price.currencyCode] [nvarchar](50) NULL,
	[costOfProduction.amount] [varchar](50) NULL,
	[costOfProduction.currencyCode] [nvarchar](50) NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [varchar](50) NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [varchar](50) NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[lossReason] [nvarchar](50) NULL,
	[distributionPurpose] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[movementId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [PT].[STG_Variety]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [PT].[STG_Variety](
	[varietyId] [varchar](50) NOT NULL,
	[name] [nvarchar](255) NULL,
	[referenceNumber] [nvarchar](50) NULL,
	[genericFlag] [tinyint] NULL,
	[genericVarietyId] [varchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[species] [nvarchar](50) NULL,
	[origin] [nvarchar](50) NULL,
	[countryOfOrigin] [varchar](50) NULL,
	[geneticStatus] [nvarchar](50) NULL,
	[arabicaShape] [nvarchar](50) NULL,
	[molecularSignature] [tinyint] NULL,
	[organisationId] [varchar](50) NOT NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime] NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime] NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[parents] [nvarchar](255) NULL,
	[propMethod] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[varietyId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [stg].[AT_Observation]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[AT_Observation](
	[observationId] [varchar](50) NOT NULL,
	[status] [nvarchar](50) NULL,
	[type] [nvarchar](50) NULL,
	[obsDateTime] [datetime2](0) NULL,
	[entityId] [varchar](50) NULL,
	[criteriaId] [varchar](50) NOT NULL,
	[interactionId] [varchar](50) NOT NULL,
	[parentObservationId] [varchar](50) NULL,
	[notApplicableFlag] [tinyint] NULL,
	[riskyFlag] [tinyint] NULL,
	[answerType] [nvarchar](50) NULL,
	[answerDate] [datetime2](0) NULL,
	[answerDate2] [datetime2](0) NULL,
	[answerText] [nvarchar](max) NULL,
	[answerNumber] [float] NULL,
	[unitOfMeasure] [nvarchar](50) NULL,
	[currencyCode] [nvarchar](50) NULL,
	[comments] [nvarchar](max) NULL,
	[correctiveActions] [nvarchar](max) NULL,
	[notes] [nvarchar](max) NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime2](7) NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime2](7) NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[answerCode] [nvarchar](50) NULL,
	[isLatest] [tinyint] NULL,
	[isLatestByYear] [tinyint] NULL,
	[obsDateOnly] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[observationId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [stg].[CT_GeoNode]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[CT_GeoNode](
	[geoNodeId] [varchar](50) NOT NULL,
	[geoNodeType] [nvarchar](50) NOT NULL,
	[parentId] [varchar](50) NULL,
	[isLeaf] [tinyint] NULL,
	[status] [nvarchar](50) NOT NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime] NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime] NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[activationDate] [datetime] NULL,
	[name] [nvarchar](255) NOT NULL,
	[countryCode] [nvarchar](50) NULL,
	[currencyCode] [nvarchar](50) NULL,
	[lineOfBusiness] [nvarchar](50) NULL,
	[shape] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[geoNodeId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [stg].[ET_Entity]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[ET_Entity](
	[entityId] [varchar](50) NOT NULL,
	[externalSystemId] [varchar](50) NULL,
	[entityType] [nvarchar](50) NOT NULL,
	[status] [nvarchar](50) NOT NULL,
	[name] [nvarchar](255) NOT NULL,
	[coordinates.longX] [float] NULL,
	[coordinates.latY] [float] NULL,
	[altZ] [varchar](50) NULL,
	[nestleOwned] [tinyint] NULL,
	[ownershipType] [nvarchar](50) NULL,
	[geoNodeId] [varchar](50) NULL,
	[foundationYear] [varchar](50) NULL,
	[AAAEntryYear] [varchar](50) NULL,
	[relationshipDate] [varchar](50) NULL,
	[nurseryOnSite] [varchar](50) NULL,
	[millOnSite] [tinyint] NULL,
	[displayPermissionOK] [tinyint] NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime] NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [varchar](50) NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[addressInfo.address1] [nvarchar](255) NULL,
	[addressInfo.address2] [nvarchar](255) NULL,
	[addressInfo.city] [nvarchar](255) NULL,
	[addressInfo.district] [nvarchar](255) NULL,
	[addressInfo.province] [nvarchar](255) NULL,
	[addressInfo.zipcode] [nvarchar](255) NULL,
	[addressInfo.countryCode] [nvarchar](50) NULL,
	[locationVerified] [tinyint] NULL,
	[geoStatus] [nvarchar](50) NULL,
	[inactivatedOn] [datetime] NULL,
	[AAAEnrolmentDate] [datetime] NULL,
	[AAAStatus] [nvarchar](50) NULL,
	[4CStatus] [nvarchar](50) NULL,
	[openQuantity] [int] NULL,
	[registrationNo] [nvarchar](50) NULL,
	[managingEntity] [nvarchar](255) NULL,
	[mainActivity] [nvarchar](50) NULL,
	[verificationType] [nvarchar](50) NULL,
	[completionDate] [datetime] NULL,
	[isPartOfAgripreneurship] [nvarchar](50) NULL,
	[subEntityType] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[entityId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [stg].[IT_Interaction]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[IT_Interaction](
	[interactionId] [varchar](50) NOT NULL,
	[type] [varchar](50) NULL,
	[name] [varchar](255) NULL,
	[notes] [varchar](max) NULL,
	[location] [varchar](max) NULL,
	[status] [varchar](50) NULL,
	[entityId] [varchar](50) NULL,
	[employeeId] [varchar](50) NULL,
	[eventId] [varchar](50) NULL,
	[varietyTrialId] [varchar](50) NULL,
	[siteTrialId] [varchar](50) NULL,
	[personId] [varchar](50) NULL,
	[templateId] [varchar](50) NULL,
	[startDate] [datetime] NULL,
	[endDate] [datetime] NULL,
	[geoNodeId] [varchar](50) NULL,
	[organisationId] [varchar](50) NOT NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime2](7) NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime2](7) NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [varchar](50) NULL,
	[auditInfo.channel] [varchar](50) NULL,
	[correctiveActions] [varchar](max) NULL,
	[movementId] [varchar](50) NULL,
	[transactionId] [varchar](50) NULL,
	[startDateOnly] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[interactionId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [stg].[PT_Movement]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[PT_Movement](
	[movementId] [varchar](50) NOT NULL,
	[type] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[varietyId] [varchar](50) NULL,
	[propagationMethod] [nvarchar](50) NULL,
	[shipmentIdentifier] [nvarchar](255) NULL,
	[startEntityId] [varchar](50) NOT NULL,
	[endEntityId] [varchar](50) NOT NULL,
	[senderId] [varchar](50) NULL,
	[sentOn] [varchar](50) NULL,
	[sentQty] [int] NULL,
	[receiverId] [varchar](50) NULL,
	[receivedOn] [varchar](50) NULL,
	[receivedQty] [int] NULL,
	[price.amount] [varchar](50) NULL,
	[price.currencyCode] [nvarchar](50) NULL,
	[costOfProduction.amount] [varchar](50) NULL,
	[costOfProduction.currencyCode] [nvarchar](50) NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [varchar](50) NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [varchar](50) NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[lossReason] [nvarchar](50) NULL,
	[distributionPurpose] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[movementId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [stg].[PT_Variety]    Script Date: 27-01-2021 04:26:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [stg].[PT_Variety](
	[varietyId] [varchar](50) NOT NULL,
	[name] [nvarchar](255) NULL,
	[referenceNumber] [nvarchar](50) NULL,
	[genericFlag] [tinyint] NULL,
	[genericVarietyId] [varchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[species] [nvarchar](50) NULL,
	[origin] [nvarchar](50) NULL,
	[countryOfOrigin] [varchar](50) NULL,
	[geneticStatus] [nvarchar](50) NULL,
	[arabicaShape] [nvarchar](50) NULL,
	[molecularSignature] [tinyint] NULL,
	[organisationId] [varchar](50) NOT NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [datetime] NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [datetime] NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[parents] [nvarchar](255) NULL,
	[propMethod] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[varietyId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dwh].[AT_Observation] ADD  DEFAULT ((0)) FOR [notApplicableFlag]
GO
ALTER TABLE [dwh].[AT_Observation] ADD  DEFAULT ((0)) FOR [riskyFlag]
GO
ALTER TABLE [dwh].[AT_Observation] ADD  DEFAULT ((0)) FOR [isLatest]
GO
ALTER TABLE [dwh].[AT_Observation] ADD  DEFAULT ((0)) FOR [isLatestByYear]
GO
ALTER TABLE [dwh].[CT_GeoNode] ADD  DEFAULT ((0)) FOR [isLeaf]
GO
ALTER TABLE [dwh].[ET_Entity] ADD  DEFAULT ((0)) FOR [nestleOwned]
GO
ALTER TABLE [dwh].[ET_Entity] ADD  DEFAULT ((0)) FOR [nurseryOnSite]
GO
ALTER TABLE [dwh].[ET_Entity] ADD  DEFAULT ((0)) FOR [millOnSite]
GO
ALTER TABLE [dwh].[ET_Entity] ADD  DEFAULT ((0)) FOR [displayPermissionOK]
GO
ALTER TABLE [dwh].[ET_Entity] ADD  DEFAULT ((0)) FOR [locationVerified]
GO
ALTER TABLE [dwh].[PT_Variety] ADD  DEFAULT ((0)) FOR [genericFlag]
GO
ALTER TABLE [dwh].[PT_Variety] ADD  DEFAULT ((0)) FOR [molecularSignature]
GO
EXEC sys.sp_addextendedproperty @name=N'microsoft_database_tools_support', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'sysdiagrams'
GO
