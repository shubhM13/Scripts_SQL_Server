CREATE TABLE dm.dim_certification (
	certificationId VARCHAR(50) NOT NULL
	,certificationEntityId VARCHAR(50)
	,certificationType NVARCHAR(50)
	,certificationDate DATETIME2(0)
	,certificationNumber NVARCHAR(50)
	,certificationAverageScore FLOAT(53)
	,certificationStatus NVARCHAR(50)
	,certificationGroup VARCHAR(50)
	,certifiedBy VARCHAR(50)
	,certificationExpiryDate DATETIME2(0)
	,certificationTypeLabel NVARCHAR(1000)
	,certificationStatusLabel NVARCHAR(1000)
	,certificationGroupName NVARCHAR(255)
	,PRIMARY KEY (certificationId)
	);