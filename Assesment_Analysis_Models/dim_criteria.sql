CREATE TABLE dm.dim_criteria (
	criteriaId VARCHAR(50) NOT NULL
	,criteriaCode NVARCHAR(50)
	,criteriaStatus NVARCHAR(50)
	,criteriaClassification1 NVARCHAR(50)
	,criteriaClassification2 NVARCHAR(50)
	,criteriaClassification3 NVARCHAR(50)
	,criteriaComplianceFlag TINYINT
	,criteriaAnswerType NVARCHAR(50)
	,criteriaTitle NVARCHAR(255)
	,criteriaShortDescription NVARCHAR(3000)
	,criteriaLongDescription NVARCHAR(max)
	,criteriaAnswerTypeTxt NVARCHAR(1000)
	,classification1Txt NVARCHAR(1000)
	,classification2Txt NVARCHAR(1000)
	,classification3Txt NVARCHAR(1000)
	,PRIMARY KEY (criteriaId)
	);