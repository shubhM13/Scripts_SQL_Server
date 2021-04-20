CREATE TABLE dm.dim_criteria_topic (
	criteriaTopicCriteriaId VARCHAR(50) NOT NULL
	,criteriaTopicCode NVARCHAR(50) NOT NULL
	,topicTxt NVARCHAR(1000)
	,PRIMARY KEY (
		criteriaTopicCriteriaId
		,criteriaTopicCode
		)
	);