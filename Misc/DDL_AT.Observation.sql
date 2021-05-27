CREATE TABLE DS.AT.Observation (
	"observationId" VARCHAR(50) NOT NULL
	,"status" NVARCHAR(50)
	,"type" NVARCHAR(50)
	,"obsDateTime" DATETIME2(0)
	,"entityId" VARCHAR(50)
	,"criteriaId" VARCHAR(50) NOT NULL
	,"interactionId" VARCHAR(50) NOT NULL
	,"parentObservationId" VARCHAR(50)
	,"notApplicableFlag" TINYINT
	,"riskyFlag" TINYINT
	,"answerType" NVARCHAR(50)
	,"answerDate" DATETIME2(0)
	,"answerDate2" DATETIME2(0)
	,"answerText" NVARCHAR(MAX)
	,"answerNumber" DOUBLE PRECISION
	,"unitOfMeasure" NVARCHAR(50)
	,"currencyCode" NVARCHAR(50)
	,"comments" NVARCHAR(MAX)
	,"correctiveActions" NVARCHAR(MAX)
	,"notes" NVARCHAR(MAX)
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,"answerCode" NVARCHAR(50)
	,"isLatest" TINYINT DEFAULT 0
	,"isLatestByYear" TINYINT DEFAULT 0
	,"obsDateOnly" DATE DEFAULT GETDATE()
	,PRIMARY KEY ("observationId")
	);