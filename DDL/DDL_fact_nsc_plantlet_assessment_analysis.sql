/****** Object:  Table [dm].[fact_nsc_plantlet_assessment_analysis]    Script Date: 27-01-2021 10:33:09 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dm].[fact_nsc_plantlet_assessment_analysis](
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
	[answerCode] [nvarchar](50) NULL,
	[isLatest] [tinyint] NULL,
	[isLatestByYear] [tinyint] NULL,
	[obsDateOnly] [date] NULL,
	[geoNodeId] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[observationId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_assessment_analysis] ADD  DEFAULT ((0)) FOR [notApplicableFlag]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_assessment_analysis] ADD  DEFAULT ((0)) FOR [riskyFlag]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_assessment_analysis] ADD  DEFAULT ((0)) FOR [isLatest]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_assessment_analysis] ADD  DEFAULT ((0)) FOR [isLatestByYear]
GO


