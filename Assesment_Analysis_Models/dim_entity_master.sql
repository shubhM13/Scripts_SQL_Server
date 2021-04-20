/****** Object:  Table [dm].[dim_entity_master]    Script Date: 24-02-2021 02:13:49 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dm].[dim_entity_master](
	[entityId] [varchar](50) NOT NULL,
	[externalSystemId] [varchar](50) NOT NULL,
	[entityType] [nvarchar](50) NOT NULL,
	[entityTypeTxt] [nvarchar](1000) NOT NULL,
	[entityStatus] [nvarchar](50) NOT NULL,
	[entityStatusTxt] [nvarchar](1000) NOT NULL,
	[entityName] [nvarchar](255) NOT NULL,
	[longX] [float] NULL,
	[latY] [float] NULL,
	[altZ] [float] NULL,
	[nestleOwned] [bit] NOT NULL,
	[ownershipType] [nvarchar](50) NOT NULL,
	[ownershipTypeTxt] [nvarchar](1000) NOT NULL,
	[foundationYear] [int] NULL,
	[relationshipDateKey] [int] NULL,
	[relationshipDate] [date] NULL,
	[nurseryOnSite] [bit] NOT NULL,
	[millOnSite] [bit] NOT NULL,
	[isPartOfAgripreneurship] [bit] NOT NULL,
	[locationVerified] [bit] NULL,
	[isValidCoordinates] [bit] NULL,
	[status4C] [nvarchar](50) NOT NULL,
	[status4CTxt] [nvarchar](1000) NOT NULL,
	[AAAEntryYear] [int] NULL,
	[AAAEnrolmentDateKey] [int] NULL,
	[AAAEnrolmentDate] [date] NULL,
	[AAAStatus] [nvarchar](50) NOT NULL,
	[AAAStatusTxt] [nvarchar](1000) NOT NULL,
	[license4C] [nvarchar](50) NOT NULL,
	[unit4C] [varchar](50) NOT NULL,
	[subcluster_name] [nvarchar](255) NOT NULL,
	[cluster_name] [nvarchar](255) NOT NULL,
	[country_name] [nvarchar](255) NOT NULL,
 CONSTRAINT [entiyMaster_pk] PRIMARY KEY CLUSTERED 
(
	[entityId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


