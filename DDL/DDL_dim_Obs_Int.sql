CREATE TABLE dm.fact_nsc_plantlet_assessment (
	observationId VARCHAR(50) NOT NULL
	,status NVARCHAR(50)
	,type NVARCHAR(50)
	,obsDateTime DATETIME2(0)
	,entityId VARCHAR(50)
	,criteriaId VARCHAR(50) NOT NULL
	,interactionId VARCHAR(50) NOT NULL
	,parentObservationId VARCHAR(50)
	,notApplicableFlag TINYINT DEFAULT 0
	,riskyFlag TINYINT DEFAULT 0
	,answerType NVARCHAR(50)
	,answerDate DATETIME2(0)
	,answerDate2 DATETIME2(0)
	,answerText NVARCHAR(MAX)
	,answerNumber FLOAT(53)
	,unitOfMeasure NVARCHAR(50)
	,currencyCode NVARCHAR(50)
	,answerCode NVARCHAR(50)
	,isLatest TINYINT DEFAULT 0
	,isLatestByYear TINYINT DEFAULT 0
	,obsDateOnly DATE DEFAULT CONVERT(date, obsDateTime)
	,PRIMARY KEY (observationId)
	);


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dm].[dim_interaction](
	[interactionId] [varchar](50) NOT NULL,
	[type] [nvarchar](50) NULL,
	[name] [nvarchar](255) NULL,
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
	[movementId] [varchar](50) NULL,
	[transactionId] [varchar](50) NULL,
	[startDateOnly] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[interactionId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

/****** Object:  Table [dm].[dim_variety]    Script Date: 27-01-2021 06:17:17 ******/
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

