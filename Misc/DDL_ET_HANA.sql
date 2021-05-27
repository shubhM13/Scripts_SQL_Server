CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.Certification"(
	"certificationId" VARCHAR(50) NOT NULL,
	"entityId" VARCHAR(50),
	"type" NVARCHAR(50),
	"certificationDate" SECONDDATE CS_SECONDDATE,
	"certificationNumber" NVARCHAR(50),
	"averageScore" DOUBLE CS_DOUBLE,
	"status" NVARCHAR(50),
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	"certificationGroup" VARCHAR(50),
	"certifiedBy" VARCHAR(50),
	"certificationExpiryDate" SECONDDATE CS_SECONDDATE,
	PRIMARY KEY (
		"certificationId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.Certification_Landing"(
	"documentId" VARCHAR(50) NOT NULL,
	"countryName" NVARCHAR(255),
	"clusterName" NVARCHAR(255),
	"certificationId" VARCHAR(50),
	"entityAAAId" VARCHAR(50),
	"type" NVARCHAR(50),
	"certificationDate" SECONDDATE CS_SECONDDATE,
	"certificationExpiryDate" SECONDDATE CS_SECONDDATE,
	"certificationNumber" NVARCHAR(50),
	"averageScore" DOUBLE CS_DOUBLE,
	"status" NVARCHAR(50),
	"certifierEmail" NVARCHAR(255),
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	"errorUI" NVARCHAR(255),
	PRIMARY KEY (
		"documentId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;

CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.Certification_Landing_History"(
	"auditDate" LONGDATE CS_LONGDATE NOT NULL,
	"auditChangedBy" NVARCHAR(50),
	"action" NVARCHAR(50),
	"documentId" VARCHAR(50) NOT NULL,
	"countryName" NVARCHAR(255),
	"clusterName" NVARCHAR(255),
	"certificationId" VARCHAR(50),
	"entityAAAId" VARCHAR(50),
	"type" NVARCHAR(50),
	"certificationDate" SECONDDATE CS_SECONDDATE,
	"certificationExpiryDate" SECONDDATE CS_SECONDDATE,
	"certificationNumber" NVARCHAR(50),
	"averageScore" DOUBLE CS_DOUBLE,
	"status" NVARCHAR(50),
	"certifierEmail" NVARCHAR(255),
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	"errorUI" NVARCHAR(255),
	PRIMARY KEY (
		"auditDate",
		"documentId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.CommodityPrice"(
	"dateOfPrice" SECONDDATE CS_SECONDDATE NOT NULL,
	"commodityType" NVARCHAR(50) NOT NULL,
	"price" DOUBLE CS_DOUBLE,
	"islatest" TINYINT CS_INT DEFAULT 0,
	"isClosingPrice" TINYINT CS_INT DEFAULT 0,
	PRIMARY KEY (
		"dateOfPrice",
		"commodityType"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.CommodityTransaction"(
	"transactionId" VARCHAR(50) NOT NULL,
	"commodityType" NVARCHAR(50) DEFAULT 'COFFEE' NOT NULL,
	"geoNodeId" VARCHAR(50) NOT NULL,
	"entityId" VARCHAR(50),
	"entityExternalId" VARCHAR(50),
	"transactionDate" SECONDDATE CS_SECONDDATE,
	"status" NVARCHAR(50) DEFAULT 'ACTIVE' NOT NULL,
	"quantity.quantity" DOUBLE CS_DOUBLE,
	"quantity.unitOfMeasure" NVARCHAR(50),
	"pointOfPurchase" NVARCHAR(255),
	"pointOfPurchaseCode" NVARCHAR(255),
	"invoiceNumber" NVARCHAR(255),
	"nespressoContractNumber" NVARCHAR(255),
	"containerNumber" NVARCHAR(255),
	"dateOfEmbarkment" SECONDDATE CS_SECONDDATE,
	"usdExchangeRate" DOUBLE CS_DOUBLE,
	"coffeeState" NVARCHAR(50),
	"dilutionRate" DOUBLE CS_DOUBLE,
	"basePrice.amount" DOUBLE CS_DOUBLE,
	"basePrice.currencyCode" NVARCHAR(50),
	"totalBasePrice.amount" DOUBLE CS_DOUBLE,
	"totalBasePrice.currencyCode" NVARCHAR(50),
	"aaaPremiumPaid.amount" DOUBLE CS_DOUBLE,
	"aaaPremiumPaid.currencyCode" NVARCHAR(50),
	"aaaFarmCertified" TINYINT CS_INT,
	"raPremiumPaid.amount" DOUBLE CS_DOUBLE,
	"raPremiumPaid.currencyCode" NVARCHAR(50),
	"rainforestCertified" TINYINT CS_INT,
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	"coffeeSpecies" NVARCHAR(50),
	PRIMARY KEY (
		"transactionId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.Consent"(
	"consentId" VARCHAR(50) NOT NULL,
	"consentType" VARCHAR(50) NOT NULL,
	"entityId" VARCHAR(50),
	"personId" VARCHAR(50) NOT NULL,
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	PRIMARY KEY (
		"consentId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.Entity"(
	"entityId" VARCHAR(50) NOT NULL,
	"externalSystemId" VARCHAR(50),
	"entityType" NVARCHAR(50) NOT NULL,
	"status" NVARCHAR(50) NOT NULL,
	"name" NVARCHAR(255) NOT NULL,
	"coordinates.longX" DOUBLE CS_DOUBLE,
	"coordinates.latY" DOUBLE CS_DOUBLE,
	"altZ" DOUBLE CS_DOUBLE,
	"nestleOwned" TINYINT CS_INT,
	"ownershipType" NVARCHAR(50),
	"geoNodeId" VARCHAR(50),
	"foundationYear" INTEGER CS_INT,
	"AAAEntryYear" INTEGER CS_INT,
	"relationshipDate" SECONDDATE CS_SECONDDATE,
	"nurseryOnSite" TINYINT CS_INT DEFAULT 0,
	"millOnSite" TINYINT CS_INT DEFAULT 0,
	"displayPermissionOK" TINYINT CS_INT,
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	"addressInfo.address1" NVARCHAR(255),
	"addressInfo.address2" NVARCHAR(255),
	"addressInfo.city" NVARCHAR(255),
	"addressInfo.district" NVARCHAR(255),
	"addressInfo.province" NVARCHAR(255),
	"addressInfo.zipcode" NVARCHAR(255),
	"addressInfo.countryCode" NVARCHAR(50),
	"locationVerified" TINYINT CS_INT,
	"geoStatus" NVARCHAR(50),
	"inactivatedOn" SECONDDATE CS_SECONDDATE,
	"AAAEnrolmentDate" SECONDDATE CS_SECONDDATE,
	"AAAStatus" NVARCHAR(50),
	"4CStatus" NVARCHAR(50),
	"openQuantity" INTEGER CS_INT,
	"registrationNo" NVARCHAR(50),
	"managingEntity" NVARCHAR(255),
	"mainActivity" NVARCHAR(50),
	"verificationType" NVARCHAR(50),
	"completionDate" SECONDDATE CS_SECONDDATE,
	"isPartOfAgripreneurship" NVARCHAR(50),
	"subEntityType" NVARCHAR(50) DEFAULT 'INTERNAL',
	PRIMARY KEY (
		"entityId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.EntityGeoSpatial" (
	"entityId_geo" VARCHAR(50) NOT NULL
	,"entityGeoLocation" ST_GEOMETRY(1000004326) CS_GEOMETRY
	,PRIMARY KEY ("entityId_geo")
	) UNLOAD PRIORITY 5 AUTO MERGE;

CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.EntityLanding"(
	"documentId" VARCHAR(50) NOT NULL,
	"countryName" NVARCHAR(255),
	"clusterName" NVARCHAR(255),
	"subClusterName" NVARCHAR(255),
	"lastModified" SECONDDATE CS_SECONDDATE,
	"varietyName1" NVARCHAR(255),
	"varietyName2" NVARCHAR(255),
	"varietyName3" NVARCHAR(255),
	"varietyName4" NVARCHAR(255),
	"varietyName5" NVARCHAR(255),
	"entityType" NVARCHAR(50),
	"status" NVARCHAR(50),
	"name" NVARCHAR(255),
	"coordinates.longX" DOUBLE CS_DOUBLE,
	"coordinates.latY" DOUBLE CS_DOUBLE,
	"altZ" DOUBLE CS_DOUBLE,
	"AAAEntryYear" INTEGER CS_INT,
	"relationshipDate" SECONDDATE CS_SECONDDATE,
	"addressInfo.address1" NVARCHAR(255),
	"addressInfo.address2" NVARCHAR(255),
	"addressInfo.city" NVARCHAR(255),
	"addressInfo.district" NVARCHAR(255),
	"addressInfo.province" NVARCHAR(255),
	"addressInfo.zipcode" NVARCHAR(255),
	"addressInfo.countryCode" NVARCHAR(50),
	"inactivatedOn" SECONDDATE CS_SECONDDATE,
	"entityExternalId" VARCHAR(50),
	"entityIdNew" VARCHAR(50),
	"millYesNo" TINYINT CS_INT,
	"nurseryYesNo" TINYINT CS_INT,
	"percentage1" DOUBLE CS_DOUBLE,
	"percentage2" DOUBLE CS_DOUBLE,
	"percentage3" DOUBLE CS_DOUBLE,
	"percentage4" DOUBLE CS_DOUBLE,
	"percentage5" DOUBLE CS_DOUBLE,
	"foundationYear" INTEGER CS_INT,
	"ownershipType" NVARCHAR(50),
	"AAAEnrolmentDate" SECONDDATE CS_SECONDDATE,
	"AAAStatus" NVARCHAR(50),
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	"errroUI" NVARCHAR(1000),
	"isPartOfAgripreneurship" NVARCHAR(50),
	"subEntityType" NVARCHAR(50),
	"errorUI" NVARCHAR(1000),
	"locationVerified" TINYINT CS_INT,
	PRIMARY KEY (
		"documentId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.EntityLanding_History"(
	"auditDate" LONGDATE CS_LONGDATE NOT NULL,
	"auditChangedBy" NVARCHAR(50),
	"action" NVARCHAR(50),
	"documentId" VARCHAR(50) NOT NULL,
	"countryName" NVARCHAR(255),
	"clusterName" NVARCHAR(255),
	"subClusterName" NVARCHAR(255),
	"lastModified" SECONDDATE CS_SECONDDATE,
	"varietyName1" NVARCHAR(255),
	"varietyName2" NVARCHAR(255),
	"varietyName3" NVARCHAR(255),
	"varietyName4" NVARCHAR(255),
	"varietyName5" NVARCHAR(255),
	"entityType" NVARCHAR(50),
	"subEntityType" NVARCHAR(50),
	"status" NVARCHAR(50),
	"name" NVARCHAR(255),
	"coordinates.longX" DOUBLE CS_DOUBLE,
	"coordinates.latY" DOUBLE CS_DOUBLE,
	"altZ" DOUBLE CS_DOUBLE,
	"AAAEntryYear" INTEGER CS_INT,
	"relationshipDate" SECONDDATE CS_SECONDDATE,
	"addressInfo.address1" NVARCHAR(255),
	"addressInfo.address2" NVARCHAR(255),
	"addressInfo.city" NVARCHAR(255),
	"addressInfo.district" NVARCHAR(255),
	"addressInfo.province" NVARCHAR(255),
	"addressInfo.zipcode" NVARCHAR(255),
	"addressInfo.countryCode" NVARCHAR(50),
	"inactivatedOn" SECONDDATE CS_SECONDDATE,
	"entityExternalId" VARCHAR(50),
	"entityIdNew" VARCHAR(50),
	"millYesNo" TINYINT CS_INT,
	"nurseryYesNo" TINYINT CS_INT,
	"percentage1" DOUBLE CS_DOUBLE,
	"percentage2" DOUBLE CS_DOUBLE,
	"percentage3" DOUBLE CS_DOUBLE,
	"percentage4" DOUBLE CS_DOUBLE,
	"percentage5" DOUBLE CS_DOUBLE,
	"foundationYear" INTEGER CS_INT,
	"ownershipType" NVARCHAR(50),
	"AAAEnrolmentDate" SECONDDATE CS_SECONDDATE,
	"AAAStatus" NVARCHAR(50),
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	"errroUI" NVARCHAR(1000),
	"isPartOfAgripreneurship" NVARCHAR(50),
	"errorUI" NVARCHAR(1000),
	"locationVerified" TINYINT CS_INT,
	PRIMARY KEY (
		"auditDate",
		"documentId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.EntityToEmployee"(
	"entityId" VARCHAR(50) NOT NULL,
	"employeeId" VARCHAR(50) NOT NULL,
	"relationWithEntity" NVARCHAR(50),
	PRIMARY KEY (
		"entityId",
		"employeeId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.EntityToEmployeeLanding"(
	"documentId" VARCHAR(50) NOT NULL,
	"entityId" VARCHAR(50),
	"employeeId" VARCHAR(50),
	"externalSystemId" VARCHAR(50),
	"countryName" NVARCHAR(255),
	"clusterName" NVARCHAR(255),
	"userEmail" NVARCHAR(255),
	"relationWithEntity" NVARCHAR(50),
	"action" NVARCHAR(50),
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	PRIMARY KEY (
		"documentId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.EntityToEmployee_History"(
	"auditDate" LONGDATE CS_LONGDATE NOT NULL,
	"auditChangedBy" NVARCHAR(50),
	"action" NVARCHAR(50),
	"entityId" VARCHAR(50) NOT NULL,
	"employeeId" VARCHAR(50) NOT NULL,
	"relationWithEntity" NVARCHAR(50),
	PRIMARY KEY (
		"auditDate",
		"entityId",
		"employeeId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.EntityToEntity"(
	"entityId" VARCHAR(50) NOT NULL,
	"relatedEntityId" VARCHAR(50) NOT NULL,
	"relationshipType" NVARCHAR(50) NOT NULL,
	PRIMARY KEY (
		"entityId",
		"relatedEntityId",
		"relationshipType"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.EntityToEntity_History"(
	"auditDate" LONGDATE CS_LONGDATE NOT NULL,
	"auditChangedBy" NVARCHAR(50),
	"action" NVARCHAR(50),
	"entityId" VARCHAR(50) NOT NULL,
	"relatedEntityId" VARCHAR(50) NOT NULL,
	"relationshipType" NVARCHAR(50) NOT NULL,
	PRIMARY KEY (
		"auditDate",
		"entityId",
		"relatedEntityId",
		"relationshipType"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.Entity_History"(
	"auditDate" LONGDATE CS_LONGDATE NOT NULL,
	"auditChangedBy" NVARCHAR(50),
	"action" NVARCHAR(50),
	"entityId" VARCHAR(50) NOT NULL,
	"externalSystemId" VARCHAR(50),
	"entityType" NVARCHAR(50) NOT NULL,
	"status" NVARCHAR(50) NOT NULL,
	"name" NVARCHAR(255) NOT NULL,
	"coordinates.longX" DOUBLE CS_DOUBLE,
	"coordinates.latY" DOUBLE CS_DOUBLE,
	"altZ" DOUBLE CS_DOUBLE,
	"nestleOwned" TINYINT CS_INT,
	"ownershipType" NVARCHAR(50),
	"geoNodeId" VARCHAR(50),
	"foundationYear" INTEGER CS_INT,
	"AAAEntryYear" INTEGER CS_INT,
	"relationshipDate" SECONDDATE CS_SECONDDATE,
	"nurseryOnSite" TINYINT CS_INT,
	"millOnSite" TINYINT CS_INT,
	"displayPermissionOK" TINYINT CS_INT,
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	"addressInfo.address1" NVARCHAR(255),
	"addressInfo.address2" NVARCHAR(255),
	"addressInfo.city" NVARCHAR(255),
	"addressInfo.district" NVARCHAR(255),
	"addressInfo.province" NVARCHAR(255),
	"addressInfo.zipcode" NVARCHAR(255),
	"addressInfo.countryCode" NVARCHAR(50),
	"locationVerified" TINYINT CS_INT,
	"geoStatus" NVARCHAR(50),
	"inactivatedOn" SECONDDATE CS_SECONDDATE,
	"AAAEnrolmentDate" SECONDDATE CS_SECONDDATE,
	"AAAStatus" NVARCHAR(50),
	"4CStatus" NVARCHAR(50),
	"openQuantity" INTEGER CS_INT,
	"registrationNo" NVARCHAR(50),
	"managingEntity" NVARCHAR(255),
	"mainActivity" NVARCHAR(50),
	"verificationType" NVARCHAR(50),
	"completionDate" SECONDDATE CS_SECONDDATE,
	"isPartOfAgripreneurship" NVARCHAR(50),
	"subEntityType" NVARCHAR(50) DEFAULT 'INTERNAL',
	PRIMARY KEY (
		"auditDate",
		"entityId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.Group" (
	"groupId" VARCHAR(50) NOT NULL
	,"externalSystemId" VARCHAR(50)
	,"organisationId" VARCHAR(50) NOT NULL
	,"type" NVARCHAR(50) NOT NULL
	,"name" NVARCHAR(255) NOT NULL
	,"description" NCLOB ST_MEMORY_LOB
	,"budget.amount" DOUBLE CS_DOUBLE
	,"budget.currencyCode" NVARCHAR(50)
	,"certificationType" NVARCHAR(50)
	,"certificationDate" SECONDDATE CS_SECONDDATE
	,"certificationExpiryDate" SECONDDATE CS_SECONDDATE
	,"certificationNumber" NVARCHAR(50)
	,"certificationAvgScore" DOUBLE CS_DOUBLE
	,"certificationStatus" NVARCHAR(50)
	,"certifiedBy" VARCHAR(50)
	,"status" NVARCHAR(50)
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" LONGDATE CS_LONGDATE
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" LONGDATE CS_LONGDATE
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,"ruleId" VARCHAR(50)
	,"isDynamic" TINYINT CS_INT DEFAULT 0
	,PRIMARY KEY ("groupId")
	) UNLOAD PRIORITY 5 AUTO


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.GroupToEmployee"(
	"groupId" VARCHAR(50) NOT NULL,
	"employeeId" VARCHAR(50) NOT NULL,
	PRIMARY KEY (
		"groupId",
		"employeeId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.GroupToEntity"(
	"groupId" VARCHAR(50) NOT NULL,
	"entityId" VARCHAR(50) NOT NULL,
	PRIMARY KEY (
		"groupId",
		"entityId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.GroupToEntityLanding"(
	"documentId" VARCHAR(50) NOT NULL,
	"entityExternalId" VARCHAR(50),
	"entityId" VARCHAR(50),
	"countryName" NVARCHAR(255),
	"clusterName" NVARCHAR(255),
	"organisationName" NVARCHAR(255),
	"type" NVARCHAR(50),
	"name" NVARCHAR(255),
	"action" NVARCHAR(50),
	"groupExternalId" VARCHAR(50),
	"groupId" VARCHAR(50),
	"status" NVARCHAR(50),
	"organisationId" VARCHAR(50),
	"requestedBy" VARCHAR(32),
	"errorUI" NVARCHAR(1000),
	"errorAndWarnings" NVARCHAR(5000),
	"csvUploadlanguage" NVARCHAR(2),
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	PRIMARY KEY (
		"documentId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.GroupToEntityLanding_History"(
	"auditDate" LONGDATE CS_LONGDATE NOT NULL,
	"auditChangedBy" NVARCHAR(50),
	"action" NVARCHAR(50),
	"documentId" VARCHAR(50) NOT NULL,
	"entityExternalId" VARCHAR(50),
	"entityId" VARCHAR(50),
	"countryName" NVARCHAR(255),
	"clusterName" NVARCHAR(255),
	"organisationName" NVARCHAR(255),
	"type" NVARCHAR(50),
	"name" NVARCHAR(255),
	"actions" NVARCHAR(50),
	"groupExternalId" VARCHAR(50),
	"groupId" VARCHAR(50),
	"status" NVARCHAR(50),
	"organisationId" VARCHAR(50),
	"requestedBy" VARCHAR(32),
	"errorUI" NVARCHAR(1000),
	"errorAndWarnings" NVARCHAR(5000),
	"csvUploadlanguage" NVARCHAR(2),
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	PRIMARY KEY (
		"auditDate",
		"documentId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;



CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.GroupToOrg"(
	"groupId" VARCHAR(50) NOT NULL,
	"organisationId" VARCHAR(50) NOT NULL,
	PRIMARY KEY (
		"groupId",
		"organisationId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.Group_History" (
	"auditDate" LONGDATE CS_LONGDATE NOT NULL
	,"auditChangedBy" NVARCHAR(50)
	,"action" NVARCHAR(50)
	,"groupId" VARCHAR(50) NOT NULL
	,"externalSystemId" VARCHAR(50)
	,"organisationId" VARCHAR(50) NOT NULL
	,"type" NVARCHAR(50) NOT NULL
	,"name" NVARCHAR(255) NOT NULL
	,"description" NCLOB ST_MEMORY_LOB
	,"budget.amount" DOUBLE CS_DOUBLE
	,"budget.currencyCode" NVARCHAR(50)
	,"certificationType" NVARCHAR(50)
	,"certificationDate" SECONDDATE CS_SECONDDATE
	,"certificationExpiryDate" SECONDDATE CS_SECONDDATE
	,"certificationNumber" NVARCHAR(50)
	,"certificationAvgScore" DOUBLE CS_DOUBLE
	,"certificationStatus" NVARCHAR(50)
	,"certifiedBy" VARCHAR(50)
	,"status" NVARCHAR(50)
	,"auditInfo.createdBy" VARCHAR(50)
	,"auditInfo.createdOn" LONGDATE CS_LONGDATE
	,"auditInfo.modifiedBy" VARCHAR(50)
	,"auditInfo.modifiedOn" LONGDATE CS_LONGDATE
	,"auditInfo.requestedBy" VARCHAR(50)
	,"auditInfo.modifiedReasonCode" NVARCHAR(50)
	,"auditInfo.channel" NVARCHAR(50)
	,"ruleId" VARCHAR(50)
	,"isDynamic" TINYINT CS_INT
	,PRIMARY KEY (
		"auditDate"
		,"groupId"
		)
	) UNLOAD PRIORITY 5 AUTO

MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.Person"(
	"personId" VARCHAR(50) NOT NULL,
	"externalSystemId" VARCHAR(50),
	"externalSystemId2" VARCHAR(50),
	"status" NVARCHAR(50),
	"yearOfBirth" INTEGER CS_INT,
	"personInfo.firstName" NVARCHAR(255),
	"personInfo.lastName" NVARCHAR(255),
	"personInfo.dateOfBirth" SECONDDATE CS_SECONDDATE,
	"personInfo.gender" NVARCHAR(50),
	"personInfo.maritalStatus" NVARCHAR(50),
	"contactInfo.email" NVARCHAR(100),
	"contactInfo.mobilePhone" NVARCHAR(50),
	"contactInfo.fixedPhone" NVARCHAR(50),
	"entityId" VARCHAR(50) NOT NULL,
	"primaryIndicator" TINYINT CS_INT,
	"comment" NVARCHAR(5000),
	"yearStartedFarming" INTEGER CS_INT,
	"educationLevel" NVARCHAR(50),
	"yearsOfSchooling" INTEGER CS_INT,
	"worksWithCoffee" NVARCHAR(50),
	"relationToEntity" NVARCHAR(50),
	"livesAt" NVARCHAR(50),
	"deliversCoffee" NVARCHAR(50),
	"pictureId" VARCHAR(50),
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	"addressInfo.address1" NVARCHAR(255),
	"addressInfo.address2" NVARCHAR(255),
	"addressInfo.city" NVARCHAR(255),
	"addressInfo.district" NVARCHAR(255),
	"addressInfo.province" NVARCHAR(255),
	"addressInfo.zipcode" NVARCHAR(255),
	"addressInfo.countryCode" NVARCHAR(50),
	PRIMARY KEY (
		"personId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.PersonLanding"(
	"documentId" VARCHAR(50) NOT NULL,
	"personId" VARCHAR(50),
	"entityExternalId" VARCHAR(50),
	"countryName" NVARCHAR(255),
	"country" NVARCHAR(255),
	"clusterName" NVARCHAR(255),
	"personExternalId" VARCHAR(50),
	"externalSystemId2" VARCHAR(50),
	"status" NVARCHAR(50),
	"primaryContact" NVARCHAR(50),
	"yearOfBirth" INTEGER CS_INT,
	"birthYear" INTEGER CS_INT,
	"personInfo.firstName" NVARCHAR(255),
	"personInfo.lastName" NVARCHAR(255),
	"personInfo.dateOfBirth" SECONDDATE CS_SECONDDATE,
	"personInfo.gender" NVARCHAR(50),
	"personInfo.maritalStatus" NVARCHAR(50),
	"contactInfo.email" NVARCHAR(100),
	"contactInfo.mobilePhone" NVARCHAR(50),
	"contactInfo.fixedPhone" NVARCHAR(50),
	"comment" NVARCHAR(5000),
	"yearStartedFarming" INTEGER CS_INT,
	"educationLevel" NVARCHAR(50),
	"yearsOfSchooling" INTEGER CS_INT,
	"worksWithCoffee" NVARCHAR(50),
	"relationToEntity" NVARCHAR(50),
	"livesAt" NVARCHAR(50),
	"deliversCoffee" NVARCHAR(50),
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	"addressInfo.address1" NVARCHAR(255),
	"addressInfo.address2" NVARCHAR(255),
	"addressInfo.city" NVARCHAR(255),
	"addressInfo.district" NVARCHAR(255),
	"addressInfo.province" NVARCHAR(255),
	"addressInfo.zipcode" NVARCHAR(255),
	"addressInfo.countryCode" NVARCHAR(50),
	"errorUI" NVARCHAR(255),
	"errorAndWarnings" NVARCHAR(5000),
	"csvUploadlanguage" NVARCHAR(2),
	"lastModified" SECONDDATE CS_SECONDDATE,
	PRIMARY KEY (
		"documentId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.PersonLanding_History"(
	"auditDate" LONGDATE CS_LONGDATE NOT NULL,
	"action" NVARCHAR(50),
	"auditChangedBy" NVARCHAR(50),
	"documentId" VARCHAR(50) NOT NULL,
	"personId" VARCHAR(50),
	"entityExternalId" VARCHAR(50),
	"countryName" NVARCHAR(255),
	"country" NVARCHAR(255),
	"clusterName" NVARCHAR(255),
	"personExternalId" VARCHAR(50),
	"externalSystemId2" VARCHAR(50),
	"status" NVARCHAR(50),
	"primaryContact" NVARCHAR(50),
	"yearOfBirth" INTEGER CS_INT,
	"birthYear" INTEGER CS_INT,
	"personInfo.firstName" NVARCHAR(255),
	"personInfo.lastName" NVARCHAR(255),
	"personInfo.dateOfBirth" SECONDDATE CS_SECONDDATE,
	"personInfo.gender" NVARCHAR(50),
	"personInfo.maritalStatus" NVARCHAR(50),
	"contactInfo.email" NVARCHAR(100),
	"contactInfo.mobilePhone" NVARCHAR(50),
	"contactInfo.fixedPhone" NVARCHAR(50),
	"comment" NVARCHAR(5000),
	"yearStartedFarming" INTEGER CS_INT,
	"educationLevel" NVARCHAR(50),
	"yearsOfSchooling" INTEGER CS_INT,
	"worksWithCoffee" NVARCHAR(50),
	"relationToEntity" NVARCHAR(50),
	"livesAt" NVARCHAR(50),
	"deliversCoffee" NVARCHAR(50),
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	"addressInfo.address1" NVARCHAR(255),
	"addressInfo.address2" NVARCHAR(255),
	"addressInfo.city" NVARCHAR(255),
	"addressInfo.district" NVARCHAR(255),
	"addressInfo.province" NVARCHAR(255),
	"addressInfo.zipcode" NVARCHAR(255),
	"addressInfo.countryCode" NVARCHAR(50),
	"errorUI" NVARCHAR(255),
	"errorAndWarnings" NVARCHAR(5000),
	"csvUploadlanguage" NVARCHAR(2),
	"lastModified" SECONDDATE CS_SECONDDATE,
	PRIMARY KEY (
		"auditDate",
		"documentId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;



CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.Person_History"(
	"auditDate" LONGDATE CS_LONGDATE NOT NULL,
	"auditChangedBy" NVARCHAR(50),
	"action" NVARCHAR(50),
	"personId" VARCHAR(50) NOT NULL,
	"externalSystemId" VARCHAR(50),
	"externalSystemId2" VARCHAR(50),
	"status" NVARCHAR(50),
	"yearOfBirth" INTEGER CS_INT,
	"personInfo.firstName" NVARCHAR(255),
	"personInfo.lastName" NVARCHAR(255),
	"personInfo.dateOfBirth" SECONDDATE CS_SECONDDATE,
	"personInfo.gender" NVARCHAR(50),
	"personInfo.maritalStatus" NVARCHAR(50),
	"contactInfo.email" NVARCHAR(100),
	"contactInfo.mobilePhone" NVARCHAR(50),
	"contactInfo.fixedPhone" NVARCHAR(50),
	"entityId" VARCHAR(50) NOT NULL,
	"primaryIndicator" TINYINT CS_INT,
	"comment" NVARCHAR(5000),
	"yearStartedFarming" INTEGER CS_INT,
	"educationLevel" NVARCHAR(50),
	"yearsOfSchooling" INTEGER CS_INT,
	"worksWithCoffee" NVARCHAR(50),
	"relationToEntity" NVARCHAR(50),
	"livesAt" NVARCHAR(50),
	"deliversCoffee" NVARCHAR(50),
	"pictureId" VARCHAR(50),
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	"addressInfo.address1" NVARCHAR(255),
	"addressInfo.address2" NVARCHAR(255),
	"addressInfo.city" NVARCHAR(255),
	"addressInfo.district" NVARCHAR(255),
	"addressInfo.province" NVARCHAR(255),
	"addressInfo.zipcode" NVARCHAR(255),
	"addressInfo.countryCode" NVARCHAR(50),
	PRIMARY KEY (
		"auditDate",
		"personId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.Plot"(
	"plotId" VARCHAR(50) NOT NULL,
	"entityId" VARCHAR(50),
	"plotNumber" VARCHAR(50),
	"varietyId" VARCHAR(50),
	"area.quantity" DOUBLE CS_DOUBLE,
	"area.unitOfMeasure" NVARCHAR(50),
	"process" NVARCHAR(50),
	"numTrees" INTEGER CS_INT,
	"numStemsPerTree" INTEGER CS_INT,
	"renovationPercent" DOUBLE CS_DOUBLE,
	"replantPercent" DOUBLE CS_DOUBLE,
	"rejunvenationPercent" DOUBLE CS_DOUBLE,
	"averageAge" INTEGER CS_INT,
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	"status" NVARCHAR(50),
	"initialPlantingDate" SECONDDATE CS_SECONDDATE,
	"treesDensity" INTEGER CS_INT,
	"productivity" INTEGER CS_INT,
	"productivityUOM" NVARCHAR(50),
	PRIMARY KEY (
		"plotId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;


CREATE COLUMN TABLE "FARMS"."nestle.dev.glb.farms.data.structure::ET.Plot_History"(
	"auditChangedBy" NVARCHAR(50),
	"action" NVARCHAR(50),
	"auditDate" LONGDATE CS_LONGDATE NOT NULL,
	"plotId" VARCHAR(50) NOT NULL,
	"entityId" VARCHAR(50),
	"plotNumber" VARCHAR(50),
	"varietyId" VARCHAR(50),
	"area.quantity" DOUBLE CS_DOUBLE,
	"area.unitOfMeasure" NVARCHAR(50),
	"process" NVARCHAR(50),
	"numTrees" INTEGER CS_INT,
	"numStemsPerTree" INTEGER CS_INT,
	"renovationPercent" DOUBLE CS_DOUBLE,
	"replantPercent" DOUBLE CS_DOUBLE,
	"rejunvenationPercent" DOUBLE CS_DOUBLE,
	"averageAge" INTEGER CS_INT,
	"auditInfo.createdBy" VARCHAR(50),
	"auditInfo.createdOn" LONGDATE CS_LONGDATE,
	"auditInfo.modifiedBy" VARCHAR(50),
	"auditInfo.modifiedOn" LONGDATE CS_LONGDATE,
	"auditInfo.requestedBy" VARCHAR(50),
	"auditInfo.modifiedReasonCode" NVARCHAR(50),
	"auditInfo.channel" NVARCHAR(50),
	"status" NVARCHAR(50),
	"initialPlantingDate" SECONDDATE CS_SECONDDATE,
	"treesDensity" INTEGER CS_INT,
	"productivity" INTEGER CS_INT,
	"productivityUOM" NVARCHAR(50),
	PRIMARY KEY (
		"auditDate",
		"plotId"
	)
) UNLOAD PRIORITY 5 AUTO MERGE;
