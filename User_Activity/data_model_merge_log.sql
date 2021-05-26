/****** Object:  Table [AUDIT].[SP_CONTROL_TABLE]    Script Date: 03/05/2021 2:04:00 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
--drop table [AUDIT].[data_model_merge_log]
CREATE TABLE [AUDIT].[data_model_merge_log](
	[schema_name] [varchar](100) NULL,
	[table_name] [varchar](100) NULL,
	[last_run_ts] [datetime] NULL,
	[last_run_status] [nvarchar](50) NULL,
	count int default 0
) ON [PRIMARY]
GO


ALTER TABLE [AUDIT].[data_model_merge_log]
ADD [pipeline_name] [varchar](100) NULL,
	[run_id] [varchar](100) NULL;

select * from [AUDIT].[data_model_merge_log];


