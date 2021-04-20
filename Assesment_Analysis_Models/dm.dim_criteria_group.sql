CREATE TABLE dm.criteria_group (
	criteriaGroupCriteriaId VARCHAR(50) NOT NULL
	,criteriaGroupCode NVARCHAR(50) NOT NULL
	,criteriaEvaluationContext NVARCHAR(50)
	,criteriaGroupCodeTxt NVARCHAR(1000)
	,criteriaEvaluationContextTxt NVARCHAR(1000)
	,PRIMARY KEY (
		criteriaGroupCriteriaId
		,criteriaGroupCode
		)
	);