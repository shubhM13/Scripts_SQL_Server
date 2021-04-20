/****** Object:  Table [dm].[dim_template]    Script Date: 24-02-2021 05:12:59 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dm].[dim_template](
	[templateId] [varchar](50) NOT NULL,
	[templateStatus] [nvarchar](50) NOT NULL,
	[templateType] [nvarchar](50) NOT NULL,
	[templateApplyToAllGeoNodes] [bit] NULL,
	[templateApplyToAllOrgs] [bit] NULL,
	[templateActivityType] [nvarchar](50) NOT NULL,
	[templateApplyToAllSuppliers] [bit] NULL,
	[templateApplyToAllPartners] [bit] NULL,
	[templateApplyToAllCertPartners] [bit] NULL,
	[templateOrganisationId] [varchar](50) NOT NULL,
	[templateTitle] [nvarchar](255) NOT NULL,
	[templateDescription] [nvarchar](3000) NOT NULL,
	[templateTypeTxt] [nvarchar](1000) NOT NULL,
	[activityTypeTxt] [nvarchar](1000) NOT NULL,
	[templateStatusTxt] [nvarchar](1000) NOT NULL,
 CONSTRAINT [dimTemplate_pk] PRIMARY KEY CLUSTERED 
(
	[templateId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


