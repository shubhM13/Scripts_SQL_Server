CREATE TABLE DS.ET.GROUP (
		"groupId" VARCHAR(50) NOT NULL
		,"externalSystemId" VARCHAR(50)
		,"organisationId" VARCHAR(50) NOT NULL
		,"type" NVARCHAR(50) NOT NULL
		,"name" NVARCHAR(255) NOT NULL
		,"description" NVARCHAR(MAX)
		,"budget.amount" DOUBLE PRECISION
		,"budget.currencyCode" NVARCHAR(50)
		,"certificationType" NVARCHAR(50)
		,"certificationDate" DATETIME2(0)
		,"certificationExpiryDate" DATETIME2(0)
		,"certificationNumber" NVARCHAR(50)
		,"certificationAvgScore" DOUBLE PRECISION
		,"certificationStatus" NVARCHAR(50)
		,"certifiedBy" VARCHAR(50)
		,"status" NVARCHAR(50)
		,"auditInfo.createdBy" VARCHAR(50)
		,"auditInfo.createdOn" DATETIME2
		,"auditInfo.modifiedBy" VARCHAR(50)
		,"auditInfo.modifiedOn" DATETIME2
		,"auditInfo.requestedBy" VARCHAR(50)
		,"auditInfo.modifiedReasonCode" NVARCHAR(50)
		,"auditInfo.channel" NVARCHAR(50)
		,"ruleId" VARCHAR(50)
		,"isDynamic" TINYINT DEFAULT 0
		,PRIMARY KEY ("groupId")
		);