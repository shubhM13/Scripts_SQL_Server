/****** Object:  Table [dm].[fact_nsc_plantlet_distribution]    Script Date: 02-02-2021 00:43:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
drop table [dm].[fact_nsc_plantlet_distribution];
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
	[sentOn] [int] NULL,
	[sentQty] [int] NULL,
	[receiverId] [varchar](50) NULL,
	[receivedOn] [int] NULL,
	[receivedQty] [int] NULL,
	[price.amount] FLOAT(53) NULL,
	[price.currencyCode] [nvarchar](50) NULL,
	[costOfProduction.amount] FLOAT(53) NULL,
	[costOfProduction.currencyCode] [nvarchar](50) NULL,
	[auditInfo.createdBy] [varchar](50) NULL,
	[auditInfo.createdOn] [int] NULL,
	[auditInfo.modifiedBy] [varchar](50) NULL,
	[auditInfo.modifiedOn] [int] NULL,
	[auditInfo.requestedBy] [varchar](50) NULL,
	[auditInfo.modifiedReasonCode] [nvarchar](50) NULL,
	[auditInfo.channel] [nvarchar](50) NULL,
	[lossReason] [nvarchar](50) NULL,
	[distributionPurpose] [nvarchar](50) NULL,
	[endEntityPrimaryContact] [varchar](50) NULL
PRIMARY KEY CLUSTERED 
(
	[movementId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_date] FOREIGN KEY([sentOn])
REFERENCES [dm].[dim_date] ([DateKey])
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution] CHECK CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_date]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_date1] FOREIGN KEY([receivedOn])
REFERENCES [dm].[dim_date] ([DateKey])
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution] CHECK CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_date1]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_date2] FOREIGN KEY([auditInfo.createdOn])
REFERENCES [dm].[dim_date] ([DateKey])
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution] CHECK CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_date2]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_date3] FOREIGN KEY([auditInfo.modifiedOn])
REFERENCES [dm].[dim_date] ([DateKey])
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution] CHECK CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_date3]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_employee] FOREIGN KEY([senderId])
REFERENCES [dm].[dim_employee] ([employeeId])
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution] CHECK CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_employee]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_employee1] FOREIGN KEY([receiverId])
REFERENCES [dm].[dim_employee] ([employeeId])
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution] CHECK CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_employee1]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_entity] FOREIGN KEY([startEntityId])
REFERENCES [dm].[dim_entity] ([entityId])
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution] CHECK CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_entity]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_entity1] FOREIGN KEY([endEntityId])
REFERENCES [dm].[dim_entity] ([entityId])
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution] CHECK CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_entity1]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_geonode_flat] FOREIGN KEY([startGeoNodeId])
REFERENCES [dm].[dim_geonode_flat] ([geoNodeId])
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution] CHECK CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_geonode_flat]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_geonode_flat1] FOREIGN KEY([endGeoNodeId])
REFERENCES [dm].[dim_geonode_flat] ([geoNodeId])
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution] CHECK CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_geonode_flat1]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_person] FOREIGN KEY([endEntityPrimaryContact])
REFERENCES [dm].[dim_person] ([personId])
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution] CHECK CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_person]
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution]  WITH CHECK ADD  CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_variety] FOREIGN KEY([varietyId])
REFERENCES [dm].[dim_variety] ([varietyId])
GO

ALTER TABLE [dm].[fact_nsc_plantlet_distribution] CHECK CONSTRAINT [FK_fact_nsc_plantlet_distribution_dim_variety]
GO


