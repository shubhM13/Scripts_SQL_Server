/****** Object:  Table [dm].[fact_nsc_plantlet_assessment]    Script Date: 02-02-2021 01:25:01 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
drop table [dm].[fact_nsc_plantlet_assessment];
CREATE TABLE [dm].[fact_nsc_plantlet_assessment](
	[observationId] [varchar](50) NOT NULL,
	[status] [nvarchar](50) NULL,
	[type] [nvarchar](50) NULL,
	[obsDateTime] [int] NULL,
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
	[geoNodeId] [varchar](50) NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [int] NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [int] NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[observationId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_assessment] ADD  DEFAULT ((0)) FOR [notApplicableFlag]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_assessment] ADD  DEFAULT ((0)) FOR [riskyFlag]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_assessment] ADD  DEFAULT ((0)) FOR [isLatest]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_assessment] ADD  DEFAULT ((0)) FOR [isLatestByYear]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_assessment]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_plantlet_assessment_dim_entity] FOREIGN KEY([entityId])
REFERENCES [dm].[dim_entity] ([entityId])
GO

ALTER TABLE [dm].[fact_nsc_plantlet_assessment] CHECK CONSTRAINT [FK_fact_nsc_plantlet_assessment_dim_entity]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_assessment]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_plantlet_assessment_dim_geonode_flat] FOREIGN KEY([geoNodeId])
REFERENCES [dm].[dim_geonode_flat] ([geoNodeId])
GO

ALTER TABLE [dm].[fact_nsc_plantlet_assessment] CHECK CONSTRAINT [FK_fact_nsc_plantlet_assessment_dim_geonode_flat]
GO


