/****** Object:  Table [dm].[dim_observation]    Script Date: 01-03-2021 16:03:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dm].[dim_observation](
	[observationId] [varchar](50) NOT NULL,
	[obsDate] [date] NULL,
	[obsDateKey] [int] NULL,
	[observationEntityId] [varchar](50) NOT NULL,
	[observationCriteriaId] [varchar](50) NOT NULL,
	[interactionId] [varchar](50) NOT NULL,
	[notApplicableFlag] [bit] NOT NULL,
	[answerType] [nvarchar](50) NULL,
	[answerDate] [datetime2](0) NULL,
	[answerDateKey] [int] NULL,
	[answerDate2] [datetime2](0) NULL,
	[answerDate2Key] [int] NULL,
	[answerNumber] [float] NULL,
	[answerCode] [nvarchar](50) NULL,
	[answerCodeTxt] [nvarchar](1000) NULL,
	[answerCodeScore] [int] NULL,
	[multiListAnswerCode] [nvarchar](50) NULL,
	[multiListAnswerCodeTxt] [nvarchar](1000) NULL,
	[multiListAnswerCodeScore] [int] NULL,
	[unitOfMeasure] [nvarchar](50) NOT NULL,
	[unitOfMeasureTxt] [nvarchar](1000) NOT NULL,
	[currencyCode] [nvarchar](50) NOT NULL,
	[currencyCodeTxt] [nvarchar](1000) NOT NULL,
	[isLatest] [bit] NOT NULL,
	[isLatestByYear] [bit] NOT NULL
) ON [PRIMARY]
GO


