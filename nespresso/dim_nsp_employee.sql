/****** Object:  Table [dm].[dim_employee]    Script Date: 24-03-2021 12:20:39 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dm].[dim_employee](
	[employeeId] [varchar](50) NOT NULL,
	[externalSystemId] [varchar](50) NULL,
	[organisationId] [varchar](50) NOT NULL,
	[businessRole] [nvarchar](50) NULL,
	[status] [nvarchar](50) NULL,
	[userName] [nvarchar](50) NULL,
	[personInfo.firstName] [nvarchar](255) NULL,
	[personInfo.lastName] [nvarchar](255) NULL,
	[personInfo.gender] [nvarchar](50) NULL,
	[personInfo.maritalStatus] [nvarchar](50) NULL,
	[contactInfo.email] [nvarchar](100) NULL,
	[contactInfo.mobilePhone] [nvarchar](50) NULL,
	[contactInfo.fixedPhone] [nvarchar](50) NULL,
	[languageCode] [nvarchar](2) NULL,
	[startDate] [datetime2](0) NULL,
	[endDate] [datetime2](0) NULL,
	[managerId] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[employeeId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

SELECT name AS 'Foreign Key Constraint Name', 
       OBJECT_SCHEMA_NAME(parent_object_id) + '.' + OBJECT_NAME(parent_object_id) AS 'Child Table'
FROM sys.foreign_keys 
WHERE OBJECT_SCHEMA_NAME(referenced_object_id) = 'dm' AND 
           OBJECT_NAME(referenced_object_id) = 'person'

alter table dm.fact_nsc_plantlet_distribution
drop constraint FK_fact_nsc_plantlet_distribution_dim_employee;

drop table [dm].[dim_employee];

SELECT A.[employeeId]
	   ,A.[externalSystemId]
	   ,B.[externalSystemId] AS orgExtId
	   ,B.[name] AS orgName
	   ,B.[lineOfBusiness] AS orgLoB
	   ,B.[status] AS orgStatus
	   ,A.[status] AS empStatus
	   ,A.[businessRole]
	   ,A.[userName]
	   ,A.[personInfo.firstName]
	   ,A.[personInfo.lastName]
	   ,A.[personInfo.gender]
	   ,A.[personInfo.maritalStatus]
	   ,A.[contactInfo.email] 
	   ,A.[languageCode]
	   ,A.[startDate]
	   ,A.[endDate]
	   ,A.[managerId]
INTO [dm].[dim_employee]
FROM [dwh].[CT_Employee] AS A
INNER JOIN [dwh].[CT_Organisation] AS B
ON A.organisationId = B.organisationId;

ALTER TABLE [dm].[dim_employee] ADD CONSTRAINT dimAllEmp_pk PRIMARY KEY (employeeId);

select distinct lineOfBusiness from [dwh].[CT_Organisation]

select * from [dm].[dim_employee];

select * from [dwh].[CT_Employee]
where employeeId IN (select distinct interactionEmployeeId from [dm].[fact_nsp_assessment_analysis]
where interactionEmployeeId NOT IN (select distinct employeeId from [dm].[dim_employee]))


