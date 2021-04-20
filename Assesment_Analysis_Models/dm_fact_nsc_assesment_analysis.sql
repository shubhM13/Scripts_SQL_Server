CREATE TABLE dm.fact_nsc_assesment_analysis (
	interactionId VARCHAR(50) NOT NULL
	,interactionOrgName VARCHAR(50)
	,interactionType NVARCHAR(50)
	,entityId VARCHAR(50)
	,interactionEmployeeId VARCHAR(50)
	,interactionTemplateId VARCHAR(50)
	,geoNodeId VARCHAR(50)
	,interactionStartDate DATETIME2(0)
	,interactionOrganisationId VARCHAR(50) NOT NULL
	,observationId VARCHAR(50) NOT NULL
	,observationCriteriaId VARCHAR(50) 
	,obsDateTime DATETIME2(0)
	,answerCount INT
	,notApplicableFlag TINYINT
	,answerType NVARCHAR(50)
	,answerDate DATETIME2(0)
	,answerDate2 DATETIME2(0)
	,answerText NVARCHAR(max)
	,answerNumber FLOAT(53)
	,unitOfMeasure NVARCHAR(50)
	,answerCode NVARCHAR(50)
	,currencyCode NVARCHAR(50)
	,isLatest TINYINT DEFAULT 0
	,isLatestByYear TINYINT DEFAULT 0
	,PRIMARY KEY (observationId)
	);