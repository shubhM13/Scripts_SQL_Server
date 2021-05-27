/****** Object:  Table [AUDIT].[data_model_merge_error_log]    Script Date: 27-05-2021 03:29:20 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [AUDIT].[data_model_merge_error_log](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[ErrorLine] [int] NULL,
	[ErrorMessage] [nvarchar](4000) NULL,
	[ErrorNumber] [int] NULL,
	[ErrorProcedure] [nvarchar](128) NULL,
	[Tablename] [nvarchar](500) NULL,
	[ErrorSeverity] [int] NULL,
	[ErrorState] [int] NULL,
	[DateErrorRaised] [datetime] NULL,
	[pipeline_name] [varchar](100) NULL,
	[run_id] [varchar](100) NULL
) ON [PRIMARY]
GO


