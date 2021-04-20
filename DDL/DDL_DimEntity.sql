/****** Object:  Table [dm].[dim_entity]    Script Date: 27-01-2021 08:07:31 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dm].[dim_entity](
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

ALTER TABLE [dm].[dim_entity] ADD  DEFAULT ((0)) FOR [nestleOwned]
GO

ALTER TABLE [dm].[dim_entity] ADD  DEFAULT ((0)) FOR [nurseryOnSite]
GO

ALTER TABLE [dm].[dim_entity] ADD  DEFAULT ((0)) FOR [millOnSite]
GO

ALTER TABLE [dm].[dim_entity] ADD  DEFAULT ((0)) FOR [displayPermissionOK]
GO

ALTER TABLE [dm].[dim_entity] ADD  DEFAULT ((0)) FOR [locationVerified]
GO


