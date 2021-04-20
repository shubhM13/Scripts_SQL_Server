/****** Object:  Table [dm].[dim_interaction]    Script Date: 01-03-2021 16:39:30 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dm].[dim_interaction](
	[interactionId] [varchar](50) NOT NULL,
	[interactionType] [nvarchar](50) NOT NULL,
	[interactionTypeTxt] [nvarchar](1000) NOT NULL,
	[interactionStatus] [nvarchar](50) NOT NULL,
	[interactionStatusTxt] [nvarchar](1000) NOT NULL,
	[interactionEntityId] [varchar](50) NOT NULL,
	[interactionEmployeeId] [varchar](50) NOT NULL,
	[interactionEventId] [varchar](50) NOT NULL,
	[interactionPersonId] [varchar](50) NOT NULL,
	[interactionTemplateId] [varchar](50) NOT NULL,
	[interactionStartDate] [date] NULL,
	[startDateKey] [int] NULL,
	[interactionEndDate] [date] NULL,
	[endDateKey] [int] NULL,
	[interactionOrganisationId] [varchar](50) NOT NULL,
	[interactionOrgName] [nvarchar](255) NOT NULL,
	[agronomistEmail] [nvarchar](100) NOT NULL,
	[interaction_modifiedOn] [date] NOT NULL,
	[interaction_modifiedOnKey] [int] NULL,
 CONSTRAINT [dimInteraction_pk] PRIMARY KEY CLUSTERED 
(
	[interactionId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


