CREATE TABLE DS.ET.Certification (
	"certificationId" VARCHAR(50) NOT NULL
	,"entityId" VARCHAR(50)
	,"type" NVARCHAR(50)
	,"certificationDate" DATETIME2(0)
	,"certificationNumber" NVARCHAR(50)
	,"averageScore" DOUBLE PRECISION
	,"status" NVARCHAR(50)
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,"certificationGroup" VARCHAR(50)
	,"certifiedBy" VARCHAR(50)
	,"certificationExpiryDate" DATETIME2(0)
	,PRIMARY KEY ("certificationId")
	);

CREATE TABLE DS.ET.Certification_Landing (
	"documentId" VARCHAR(50) NOT NULL
	,"countryName" NVARCHAR(255)
	,"clusterName" NVARCHAR(255)
	,"certificationId" VARCHAR(50)
	,"entityAAAId" VARCHAR(50)
	,"type" NVARCHAR(50)
	,"certificationDate" DATETIME2(0)
	,"certificationExpiryDate" DATETIME2(0)
	,"certificationNumber" NVARCHAR(50)
	,"averageScore" DOUBLE PRECISION
	,"status" NVARCHAR(50)
	,"certifierEmail" NVARCHAR(255)
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,"errorUI" NVARCHAR(255)
	,PRIMARY KEY ("documentId")
	);

CREATE TABLE DS.ET.Certification_Landing_History (
	"auditDate" DATETIME2 NOT NULL
	,"auditChangedBy" NVARCHAR(50)
	,"action" NVARCHAR(50)
	,"documentId" VARCHAR(50) NOT NULL
	,"countryName" NVARCHAR(255)
	,"clusterName" NVARCHAR(255)
	,"certificationId" VARCHAR(50)
	,"entityAAAId" VARCHAR(50)
	,"type" NVARCHAR(50)
	,"certificationDate" DATETIME2(0)
	,"certificationExpiryDate" DATETIME2(0)
	,"certificationNumber" NVARCHAR(50)
	,"averageScore" DOUBLE PRECISION
	,"status" NVARCHAR(50)
	,"certifierEmail" NVARCHAR(255)
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,"errorUI" NVARCHAR(255)
	,PRIMARY KEY (
		"auditDate"
		,"documentId"
		)
	);

CREATE TABLE DS.ET.CommodityPrice (
	"dateOfPrice" DATETIME2(0) NOT NULL
	,"commodityType" NVARCHAR(50) NOT NULL
	,"price" DOUBLE PRECISION
	,"islatest" TINYINT DEFAULT 0
	,"isClosingPrice" TINYINT DEFAULT 0
	,PRIMARY KEY (
		"dateOfPrice"
		,"commodityType"
		)
	);

CREATE TABLE DS.ET.CommodityTransaction (
	"transactionId" VARCHAR(50) NOT NULL
	,"commodityType" NVARCHAR(50) DEFAULT 'COFFEE' NOT NULL
	,"geoNodeId" VARCHAR(50) NOT NULL
	,"entityId" VARCHAR(50)
	,"entityExternalId" VARCHAR(50)
	,"transactionDate" DATETIME2(0)
	,"status" NVARCHAR(50) DEFAULT 'ACTIVE' NOT NULL
	,"quantity.quantity" DOUBLE PRECISION
	,"quantity.unitOfMeasure" NVARCHAR(50)
	,"pointOfPurchase" NVARCHAR(255)
	,"pointOfPurchaseCode" NVARCHAR(255)
	,"invoiceNumber" NVARCHAR(255)
	,"nespressoContractNumber" NVARCHAR(255)
	,"containerNumber" NVARCHAR(255)
	,"dateOfEmbarkment" DATETIME2(0)
	,"usdExchangeRate" DOUBLE PRECISION
	,"coffeeState" NVARCHAR(50)
	,"dilutionRate" DOUBLE PRECISION
	,"basePrice.amount" DOUBLE PRECISION
	,"basePrice.currencyCode" NVARCHAR(50)
	,"totalBasePrice.amount" DOUBLE PRECISION
	,"totalBasePrice.currencyCode" NVARCHAR(50)
	,"aaaPremiumPaid.amount" DOUBLE PRECISION
	,"aaaPremiumPaid.currencyCode" NVARCHAR(50)
	,"aaaFarmCertified" TINYINT
	,"raPremiumPaid.amount" DOUBLE PRECISION
	,"raPremiumPaid.currencyCode" NVARCHAR(50)
	,"rainforestCertified" TINYINT
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,"coffeeSpecies" NVARCHAR(50)
	,PRIMARY KEY ("transactionId")
	);

CREATE TABLE DS.ET.Consent (
	"consentId" VARCHAR(50) NOT NULL
	,"consentType" VARCHAR(50) NOT NULL
	,"entityId" VARCHAR(50)
	,"personId" VARCHAR(50) NOT NULL
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,PRIMARY KEY ("consentId")
	);

CREATE TABLE DS.ET.Entity (
	"entityId" VARCHAR(50) NOT NULL
	,"externalSystemId" VARCHAR(50)
	,"entityType" NVARCHAR(50) NOT NULL
	,"status" NVARCHAR(50) NOT NULL
	,"name" NVARCHAR(255) NOT NULL
	,"coordinates.longX" DOUBLE PRECISION
	,"coordinates.latY" DOUBLE PRECISION
	,"altZ" DOUBLE PRECISION
	,"nestleOwned" TINYINT
	,"ownershipType" NVARCHAR(50)
	,"geoNodeId" VARCHAR(50)
	,"foundationYear" INTEGER
	,"AAAEntryYear" INTEGER
	,"relationshipDate" DATETIME2(0)
	,"nurseryOnSite" TINYINT DEFAULT 0
	,"millOnSite" TINYINT DEFAULT 0
	,"displayPermissionOK" TINYINT
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,"addressInfo.address1" NVARCHAR(255)
	,"addressInfo.address2" NVARCHAR(255)
	,"addressInfo.city" NVARCHAR(255)
	,"addressInfo.district" NVARCHAR(255)
	,"addressInfo.province" NVARCHAR(255)
	,"addressInfo.zipcode" NVARCHAR(255)
	,"addressInfo.countryCode" NVARCHAR(50)
	,"locationVerified" TINYINT
	,"geoStatus" NVARCHAR(50)
	,"inactivatedOn" DATETIME2(0)
	,"AAAEnrolmentDate" DATETIME2(0)
	,"AAAStatus" NVARCHAR(50)
	,"4CStatus" NVARCHAR(50)
	,"openQuantity" INTEGER
	,"registrationNo" NVARCHAR(50)
	,"managingEntity" NVARCHAR(255)
	,"mainActivity" NVARCHAR(50)
	,"verificationType" NVARCHAR(50)
	,"completionDate" DATETIME2(0)
	,"isPartOfAgripreneurship" NVARCHAR(50)
	,"subEntityType" NVARCHAR(50) DEFAULT 'INTERNAL'
	,PRIMARY KEY ("entityId")
	);

CREATE TABLE DS.ET.EntityLanding (
	"documentId" VARCHAR(50) NOT NULL
	,"countryName" NVARCHAR(255)
	,"clusterName" NVARCHAR(255)
	,"subClusterName" NVARCHAR(255)
	,"lastModified" DATETIME2(0)
	,"varietyName1" NVARCHAR(255)
	,"varietyName2" NVARCHAR(255)
	,"varietyName3" NVARCHAR(255)
	,"varietyName4" NVARCHAR(255)
	,"varietyName5" NVARCHAR(255)
	,"entityType" NVARCHAR(50)
	,"status" NVARCHAR(50)
	,"name" NVARCHAR(255)
	,"coordinates.longX" DOUBLE PRECISION
	,"coordinates.latY" DOUBLE PRECISION
	,"altZ" DOUBLE PRECISION
	,"AAAEntryYear" INTEGER
	,"relationshipDate" DATETIME2(0)
	,"addressInfo.address1" NVARCHAR(255)
	,"addressInfo.address2" NVARCHAR(255)
	,"addressInfo.city" NVARCHAR(255)
	,"addressInfo.district" NVARCHAR(255)
	,"addressInfo.province" NVARCHAR(255)
	,"addressInfo.zipcode" NVARCHAR(255)
	,"addressInfo.countryCode" NVARCHAR(50)
	,"inactivatedOn" DATETIME2(0)
	,"entityExternalId" VARCHAR(50)
	,"entityIdNew" VARCHAR(50)
	,"millYesNo" TINYINT
	,"nurseryYesNo" TINYINT
	,"percentage1" DOUBLE PRECISION
	,"percentage2" DOUBLE PRECISION
	,"percentage3" DOUBLE PRECISION
	,"percentage4" DOUBLE PRECISION
	,"percentage5" DOUBLE PRECISION
	,"foundationYear" INTEGER
	,"ownershipType" NVARCHAR(50)
	,"AAAEnrolmentDate" DATETIME2(0)
	,"AAAStatus" NVARCHAR(50)
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,"errroUI" NVARCHAR(1000)
	,"isPartOfAgripreneurship" NVARCHAR(50)
	,"subEntityType" NVARCHAR(50)
	,"errorUI" NVARCHAR(1000)
	,"locationVerified" TINYINT
	,PRIMARY KEY ("documentId")
	);

CREATE TABLE DS.ET.EntityLanding_History (
	"auditDate" DATETIME2 NOT NULL
	,"auditChangedBy" NVARCHAR(50)
	,"action" NVARCHAR(50)
	,"documentId" VARCHAR(50) NOT NULL
	,"countryName" NVARCHAR(255)
	,"clusterName" NVARCHAR(255)
	,"subClusterName" NVARCHAR(255)
	,"lastModified" DATETIME2(0)
	,"varietyName1" NVARCHAR(255)
	,"varietyName2" NVARCHAR(255)
	,"varietyName3" NVARCHAR(255)
	,"varietyName4" NVARCHAR(255)
	,"varietyName5" NVARCHAR(255)
	,"entityType" NVARCHAR(50)
	,"subEntityType" NVARCHAR(50)
	,"status" NVARCHAR(50)
	,"name" NVARCHAR(255)
	,"coordinates.longX" DOUBLE PRECISION
	,"coordinates.latY" DOUBLE PRECISION
	,"altZ" DOUBLE PRECISION
	,"AAAEntryYear" INTEGER
	,"relationshipDate" DATETIME2(0)
	,"addressInfo.address1" NVARCHAR(255)
	,"addressInfo.address2" NVARCHAR(255)
	,"addressInfo.city" NVARCHAR(255)
	,"addressInfo.district" NVARCHAR(255)
	,"addressInfo.province" NVARCHAR(255)
	,"addressInfo.zipcode" NVARCHAR(255)
	,"addressInfo.countryCode" NVARCHAR(50)
	,"inactivatedOn" DATETIME2(0)
	,"entityExternalId" VARCHAR(50)
	,"entityIdNew" VARCHAR(50)
	,"millYesNo" TINYINT
	,"nurseryYesNo" TINYINT
	,"percentage1" DOUBLE PRECISION
	,"percentage2" DOUBLE PRECISION
	,"percentage3" DOUBLE PRECISION
	,"percentage4" DOUBLE PRECISION
	,"percentage5" DOUBLE PRECISION
	,"foundationYear" INTEGER
	,"ownershipType" NVARCHAR(50)
	,"AAAEnrolmentDate" DATETIME2(0)
	,"AAAStatus" NVARCHAR(50)
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,"errroUI" NVARCHAR(1000)
	,"isPartOfAgripreneurship" NVARCHAR(50)
	,"errorUI" NVARCHAR(1000)
	,"locationVerified" TINYINT
	,PRIMARY KEY (
		"auditDate"
		,"documentId"
		)
	);

CREATE TABLE DS.ET.EntityToEmployee (
	"entityId" VARCHAR(50) NOT NULL
	,"employeeId" VARCHAR(50) NOT NULL
	,"relationWithEntity" NVARCHAR(50)
	,PRIMARY KEY (
		"entityId"
		,"employeeId"
		)
	);

CREATE TABLE DS.ET.EntityToEmployeeLanding (
	"documentId" VARCHAR(50) NOT NULL
	,"entityId" VARCHAR(50)
	,"employeeId" VARCHAR(50)
	,"externalSystemId" VARCHAR(50)
	,"countryName" NVARCHAR(255)
	,"clusterName" NVARCHAR(255)
	,"userEmail" NVARCHAR(255)
	,"relationWithEntity" NVARCHAR(50)
	,"action" NVARCHAR(50)
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,PRIMARY KEY ("documentId")
	);

CREATE TABLE DS.ET.EntityToEmployee_History (
	"auditDate" DATETIME2 NOT NULL
	,"auditChangedBy" NVARCHAR(50)
	,"action" NVARCHAR(50)
	,"entityId" VARCHAR(50) NOT NULL
	,"employeeId" VARCHAR(50) NOT NULL
	,"relationWithEntity" NVARCHAR(50)
	,PRIMARY KEY (
		"auditDate"
		,"entityId"
		,"employeeId"
		)
	);

CREATE TABLE DS.ET.EntityToEntity (
	"entityId" VARCHAR(50) NOT NULL
	,"relatedEntityId" VARCHAR(50) NOT NULL
	,"relationshipType" NVARCHAR(50) NOT NULL
	,PRIMARY KEY (
		"entityId"
		,"relatedEntityId"
		,"relationshipType"
		)
	);

CREATE TABLE DS.ET.EntityToEntity_History (
	"auditDate" DATETIME2 NOT NULL
	,"auditChangedBy" NVARCHAR(50)
	,"action" NVARCHAR(50)
	,"entityId" VARCHAR(50) NOT NULL
	,"relatedEntityId" VARCHAR(50) NOT NULL
	,"relationshipType" NVARCHAR(50) NOT NULL
	,PRIMARY KEY (
		"auditDate"
		,"entityId"
		,"relatedEntityId"
		,"relationshipType"
		)
	);

CREATE TABLE DS.ET.Entity_History (
	"auditDate" DATETIME2 NOT NULL
	,"auditChangedBy" NVARCHAR(50)
	,"action" NVARCHAR(50)
	,"entityId" VARCHAR(50) NOT NULL
	,"externalSystemId" VARCHAR(50)
	,"entityType" NVARCHAR(50) NOT NULL
	,"status" NVARCHAR(50) NOT NULL
	,"name" NVARCHAR(255) NOT NULL
	,"coordinates.longX" DOUBLE PRECISION
	,"coordinates.latY" DOUBLE PRECISION
	,"altZ" DOUBLE PRECISION
	,"nestleOwned" TINYINT
	,"ownershipType" NVARCHAR(50)
	,"geoNodeId" VARCHAR(50)
	,"foundationYear" INTEGER
	,"AAAEntryYear" INTEGER
	,"relationshipDate" DATETIME2(0)
	,"nurseryOnSite" TINYINT
	,"millOnSite" TINYINT
	,"displayPermissionOK" TINYINT
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,"addressInfo.address1" NVARCHAR(255)
	,"addressInfo.address2" NVARCHAR(255)
	,"addressInfo.city" NVARCHAR(255)
	,"addressInfo.district" NVARCHAR(255)
	,"addressInfo.province" NVARCHAR(255)
	,"addressInfo.zipcode" NVARCHAR(255)
	,"addressInfo.countryCode" NVARCHAR(50)
	,"locationVerified" TINYINT
	,"geoStatus" NVARCHAR(50)
	,"inactivatedOn" DATETIME2(0)
	,"AAAEnrolmentDate" DATETIME2(0)
	,"AAAStatus" NVARCHAR(50)
	,"4CStatus" NVARCHAR(50)
	,"openQuantity" INTEGER
	,"registrationNo" NVARCHAR(50)
	,"managingEntity" NVARCHAR(255)
	,"mainActivity" NVARCHAR(50)
	,"verificationType" NVARCHAR(50)
	,"completionDate" DATETIME2(0)
	,"isPartOfAgripreneurship" NVARCHAR(50)
	,"subEntityType" NVARCHAR(50) DEFAULT 'INTERNAL'
	,PRIMARY KEY (
		"auditDate"
		,"entityId"
		)
	);

CREATE TABLE DS.ET.GroupToEmployee (
	"groupId" VARCHAR(50) NOT NULL
	,"employeeId" VARCHAR(50) NOT NULL
	,PRIMARY KEY (
		"groupId"
		,"employeeId"
		)
	);

CREATE TABLE DS.ET.GroupToEntity (
	"groupId" VARCHAR(50) NOT NULL
	,"entityId" VARCHAR(50) NOT NULL
	,PRIMARY KEY (
		"groupId"
		,"entityId"
		)
	);

CREATE TABLE DS.ET.GroupToEntityLanding (
	"documentId" VARCHAR(50) NOT NULL
	,"entityExternalId" VARCHAR(50)
	,"entityId" VARCHAR(50)
	,"countryName" NVARCHAR(255)
	,"clusterName" NVARCHAR(255)
	,"organisationName" NVARCHAR(255)
	,"type" NVARCHAR(50)
	,"name" NVARCHAR(255)
	,"action" NVARCHAR(50)
	,"groupExternalId" VARCHAR(50)
	,"groupId" VARCHAR(50)
	,"status" NVARCHAR(50)
	,"organisationId" VARCHAR(50)
	,"requestedBy" VARCHAR(32)
	,"errorUI" NVARCHAR(1000)
	,"errorAndWarnings" NVARCHAR(MAX)
	,"csvUploadlanguage" NVARCHAR(2)
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,PRIMARY KEY ("documentId")
	);

CREATE TABLE DS.ET.GroupToEntityLanding_History (
	"auditDate" DATETIME2 NOT NULL
	,"auditChangedBy" NVARCHAR(50)
	,"action" NVARCHAR(50)
	,"documentId" VARCHAR(50) NOT NULL
	,"entityExternalId" VARCHAR(50)
	,"entityId" VARCHAR(50)
	,"countryName" NVARCHAR(255)
	,"clusterName" NVARCHAR(255)
	,"organisationName" NVARCHAR(255)
	,"type" NVARCHAR(50)
	,"name" NVARCHAR(255)
	,"actions" NVARCHAR(50)
	,"groupExternalId" VARCHAR(50)
	,"groupId" VARCHAR(50)
	,"status" NVARCHAR(50)
	,"organisationId" VARCHAR(50)
	,"requestedBy" VARCHAR(32)
	,"errorUI" NVARCHAR(1000)
	,"errorAndWarnings" NVARCHAR(MAX)
	,"csvUploadlanguage" NVARCHAR(2)
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,PRIMARY KEY (
		"auditDate"
		,"documentId"
		)
	);

CREATE TABLE DS.ET.GroupToOrg (
	"groupId" VARCHAR(50) NOT NULL
	,"organisationId" VARCHAR(50) NOT NULL
	,PRIMARY KEY (
		"groupId"
		,"organisationId"
		)
	);

CREATE TABLE DS.ET.Group_History (
	"auditDate" DATETIME2 NOT NULL
	,"auditChangedBy" NVARCHAR(50)
	,"action" NVARCHAR(50)
	,"groupId" VARCHAR(50) NOT NULL
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
	,"isDynamic" TINYINT
	,PRIMARY KEY (
		"auditDate"
		,"groupId"
		)
	);

CREATE TABLE DS.ET.Person (
	"personId" VARCHAR(50) NOT NULL
	,"externalSystemId" VARCHAR(50)
	,"externalSystemId2" VARCHAR(50)
	,"status" NVARCHAR(50)
	,"yearOfBirth" INTEGER
	,"personInfo.firstName" NVARCHAR(255)
	,"personInfo.lastName" NVARCHAR(255)
	,"personInfo.dateOfBirth" DATETIME2(0)
	,"personInfo.gender" NVARCHAR(50)
	,"personInfo.maritalStatus" NVARCHAR(50)
	,"contactInfo.email" NVARCHAR(100)
	,"contactInfo.mobilePhone" NVARCHAR(50)
	,"contactInfo.fixedPhone" NVARCHAR(50)
	,"entityId" VARCHAR(50) NOT NULL
	,"primaryIndicator" TINYINT
	,"comment" NVARCHAR(MAX)
	,"yearStartedFarming" INTEGER
	,"educationLevel" NVARCHAR(50)
	,"yearsOfSchooling" INTEGER
	,"worksWithCoffee" NVARCHAR(50)
	,"relationToEntity" NVARCHAR(50)
	,"livesAt" NVARCHAR(50)
	,"deliversCoffee" NVARCHAR(50)
	,"pictureId" VARCHAR(50)
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,"addressInfo.address1" NVARCHAR(255)
	,"addressInfo.address2" NVARCHAR(255)
	,"addressInfo.city" NVARCHAR(255)
	,"addressInfo.district" NVARCHAR(255)
	,"addressInfo.province" NVARCHAR(255)
	,"addressInfo.zipcode" NVARCHAR(255)
	,"addressInfo.countryCode" NVARCHAR(50)
	,PRIMARY KEY ("personId")
	);

CREATE TABLE DS.ET.PersonLanding (
	"documentId" VARCHAR(50) NOT NULL
	,"personId" VARCHAR(50)
	,"entityExternalId" VARCHAR(50)
	,"countryName" NVARCHAR(255)
	,"country" NVARCHAR(255)
	,"clusterName" NVARCHAR(255)
	,"personExternalId" VARCHAR(50)
	,"externalSystemId2" VARCHAR(50)
	,"status" NVARCHAR(50)
	,"primaryContact" NVARCHAR(50)
	,"yearOfBirth" INTEGER
	,"birthYear" INTEGER
	,"personInfo.firstName" NVARCHAR(255)
	,"personInfo.lastName" NVARCHAR(255)
	,"personInfo.dateOfBirth" DATETIME2(0)
	,"personInfo.gender" NVARCHAR(50)
	,"personInfo.maritalStatus" NVARCHAR(50)
	,"contactInfo.email" NVARCHAR(100)
	,"contactInfo.mobilePhone" NVARCHAR(50)
	,"contactInfo.fixedPhone" NVARCHAR(50)
	,"comment" NVARCHAR(MAX)
	,"yearStartedFarming" INTEGER
	,"educationLevel" NVARCHAR(50)
	,"yearsOfSchooling" INTEGER
	,"worksWithCoffee" NVARCHAR(50)
	,"relationToEntity" NVARCHAR(50)
	,"livesAt" NVARCHAR(50)
	,"deliversCoffee" NVARCHAR(50)
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,"addressInfo.address1" NVARCHAR(255)
	,"addressInfo.address2" NVARCHAR(255)
	,"addressInfo.city" NVARCHAR(255)
	,"addressInfo.district" NVARCHAR(255)
	,"addressInfo.province" NVARCHAR(255)
	,"addressInfo.zipcode" NVARCHAR(255)
	,"addressInfo.countryCode" NVARCHAR(50)
	,"errorUI" NVARCHAR(255)
	,"errorAndWarnings" NVARCHAR(MAX)
	,"csvUploadlanguage" NVARCHAR(2)
	,"lastModified" DATETIME2(0)
	,PRIMARY KEY ("documentId")
	);

CREATE TABLE DS.ET.PersonLanding_History (
	"auditDate" DATETIME2 NOT NULL
	,"action" NVARCHAR(50)
	,"auditChangedBy" NVARCHAR(50)
	,"documentId" VARCHAR(50) NOT NULL
	,"personId" VARCHAR(50)
	,"entityExternalId" VARCHAR(50)
	,"countryName" NVARCHAR(255)
	,"country" NVARCHAR(255)
	,"clusterName" NVARCHAR(255)
	,"personExternalId" VARCHAR(50)
	,"externalSystemId2" VARCHAR(50)
	,"status" NVARCHAR(50)
	,"primaryContact" NVARCHAR(50)
	,"yearOfBirth" INTEGER
	,"birthYear" INTEGER
	,"personInfo.firstName" NVARCHAR(255)
	,"personInfo.lastName" NVARCHAR(255)
	,"personInfo.dateOfBirth" DATETIME2(0)
	,"personInfo.gender" NVARCHAR(50)
	,"personInfo.maritalStatus" NVARCHAR(50)
	,"contactInfo.email" NVARCHAR(100)
	,"contactInfo.mobilePhone" NVARCHAR(50)
	,"contactInfo.fixedPhone" NVARCHAR(50)
	,"comment" NVARCHAR(MAX)
	,"yearStartedFarming" INTEGER
	,"educationLevel" NVARCHAR(50)
	,"yearsOfSchooling" INTEGER
	,"worksWithCoffee" NVARCHAR(50)
	,"relationToEntity" NVARCHAR(50)
	,"livesAt" NVARCHAR(50)
	,"deliversCoffee" NVARCHAR(50)
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,"addressInfo.address1" NVARCHAR(255)
	,"addressInfo.address2" NVARCHAR(255)
	,"addressInfo.city" NVARCHAR(255)
	,"addressInfo.district" NVARCHAR(255)
	,"addressInfo.province" NVARCHAR(255)
	,"addressInfo.zipcode" NVARCHAR(255)
	,"addressInfo.countryCode" NVARCHAR(50)
	,"errorUI" NVARCHAR(255)
	,"errorAndWarnings" NVARCHAR(MAX)
	,"csvUploadlanguage" NVARCHAR(2)
	,"lastModified" DATETIME2(0)
	,PRIMARY KEY (
		"auditDate"
		,"documentId"
		)
	);

CREATE TABLE DS.ET.Person_History (
	"auditDate" DATETIME2 NOT NULL
	,"auditChangedBy" NVARCHAR(50)
	,"action" NVARCHAR(50)
	,"personId" VARCHAR(50) NOT NULL
	,"externalSystemId" VARCHAR(50)
	,"externalSystemId2" VARCHAR(50)
	,"status" NVARCHAR(50)
	,"yearOfBirth" INTEGER
	,"personInfo.firstName" NVARCHAR(255)
	,"personInfo.lastName" NVARCHAR(255)
	,"personInfo.dateOfBirth" DATETIME2(0)
	,"personInfo.gender" NVARCHAR(50)
	,"personInfo.maritalStatus" NVARCHAR(50)
	,"contactInfo.email" NVARCHAR(100)
	,"contactInfo.mobilePhone" NVARCHAR(50)
	,"contactInfo.fixedPhone" NVARCHAR(50)
	,"entityId" VARCHAR(50) NOT NULL
	,"primaryIndicator" TINYINT
	,"comment" NVARCHAR(MAX)
	,"yearStartedFarming" INTEGER
	,"educationLevel" NVARCHAR(50)
	,"yearsOfSchooling" INTEGER
	,"worksWithCoffee" NVARCHAR(50)
	,"relationToEntity" NVARCHAR(50)
	,"livesAt" NVARCHAR(50)
	,"deliversCoffee" NVARCHAR(50)
	,"pictureId" VARCHAR(50)
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,"addressInfo.address1" NVARCHAR(255)
	,"addressInfo.address2" NVARCHAR(255)
	,"addressInfo.city" NVARCHAR(255)
	,"addressInfo.district" NVARCHAR(255)
	,"addressInfo.province" NVARCHAR(255)
	,"addressInfo.zipcode" NVARCHAR(255)
	,"addressInfo.countryCode" NVARCHAR(50)
	,PRIMARY KEY (
		"auditDate"
		,"personId"
		)
	);

CREATE TABLE DS.ET.Plot (
	"plotId" VARCHAR(50) NOT NULL
	,"entityId" VARCHAR(50)
	,"plotNumber" VARCHAR(50)
	,"varietyId" VARCHAR(50)
	,"area.quantity" DOUBLE PRECISION
	,"area.unitOfMeasure" NVARCHAR(50)
	,"process" NVARCHAR(50)
	,"numTrees" INTEGER
	,"numStemsPerTree" INTEGER
	,"renovationPercent" DOUBLE PRECISION
	,"replantPercent" DOUBLE PRECISION
	,"rejunvenationPercent" DOUBLE PRECISION
	,"averageAge" INTEGER
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,"status" NVARCHAR(50)
	,"initialPlantingDate" DATETIME2(0)
	,"treesDensity" INTEGER
	,"productivity" INTEGER
	,"productivityUOM" NVARCHAR(50)
	,PRIMARY KEY ("plotId")
	);

CREATE TABLE DS.ET.Plot_History (
	"auditChangedBy" NVARCHAR(50)
	,"action" NVARCHAR(50)
	,"auditDate" DATETIME2 NOT NULL
	,"plotId" VARCHAR(50) NOT NULL
	,"entityId" VARCHAR(50)
	,"plotNumber" VARCHAR(50)
	,"varietyId" VARCHAR(50)
	,"area.quantity" DOUBLE PRECISION
	,"area.unitOfMeasure" NVARCHAR(50)
	,"process" NVARCHAR(50)
	,"numTrees" INTEGER
	,"numStemsPerTree" INTEGER
	,"renovationPercent" DOUBLE PRECISION
	,"replantPercent" DOUBLE PRECISION
	,"rejunvenationPercent" DOUBLE PRECISION
	,"averageAge" INTEGER
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" DATETIME2
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" DATETIME2
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,"status" NVARCHAR(50)
	,"initialPlantingDate" DATETIME2(0)
	,"treesDensity" INTEGER
	,"productivity" INTEGER
	,"productivityUOM" NVARCHAR(50)
	,PRIMARY KEY (
		"auditDate"
		,"plotId"
		)
	);