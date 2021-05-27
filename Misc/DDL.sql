--- Create Schema ds : Data Structure Schema
IF NOT EXISTS ( SELECT  *
                FROM    sys.schemas
                WHERE   name = N'ds' )
    EXEC('CREATE SCHEMA [ds]');
GO
--- Create Schema stg : Staging Schema
IF NOT EXISTS ( SELECT  *
                FROM    sys.schemas
                WHERE   name = N'stg' )
    EXEC('CREATE SCHEMA [stg]');
GO
--- Create Schema dm : Dimensional Schema
IF NOT EXISTS ( SELECT  *
                FROM    sys.schemas
                WHERE   name = N'dm' )
    EXEC('CREATE SCHEMA [dm]');
GO


---PT.MOVEMENT

CREATE TABLE DS.PT.Movement(
"movementId" VARCHAR(50) NOT NULL,
"type" NVARCHAR(50),
"status" NVARCHAR(50),
"varietyId" VARCHAR(50),
"propagationMethod" NVARCHAR(50),
"shipmentIdentifier" NVARCHAR(255),
"startEntityId" VARCHAR(50) NOT NULL,
"endEntityId" VARCHAR(50) NOT NULL,
"senderId" VARCHAR(50),
"sentOn" datetime,
"sentQty" INTEGER ,
"receiverId" VARCHAR(50),
"receivedOn" datetime,
"receivedQty" INTEGER ,
"price.amount" DECIMAL,
"price.currencyCode" NVARCHAR(50),
"costOfProduction.amount" DECIMAL,
"costOfProduction.currencyCode" NVARCHAR(50),
"auditInfo.createdBy" VARCHAR(50),
"auditInfo.createdOn" datetime,
"auditInfo.modifiedBy" VARCHAR(50),
"auditInfo.modifiedOn" datetime,
"auditInfo.requestedBy" VARCHAR(50),
"auditInfo.modifiedReasonCode" NVARCHAR(50),
"auditInfo.channel" NVARCHAR(50),
"lossReason" NVARCHAR(50),
"distributionPurpose" NVARCHAR(50),
PRIMARY KEY (
"movementId"
)
);


--PT.Variety


CREATE TABLE DS.PT.Variety(
"varietyId" VARCHAR(50) NOT NULL,
"name" NVARCHAR(255),
"referenceNumber" NVARCHAR(50),
"genericFlag" TINYINT ,
"genericVarietyId" VARCHAR(50),
"status" NVARCHAR(50),
"species" NVARCHAR(50),
"origin" NVARCHAR(50),
"countryOfOrigin" VARCHAR(50),
"geneticStatus" NVARCHAR(50),
"arabicaShape" NVARCHAR(50),
"molecularSignature" TINYINT,
"organisationId" VARCHAR(50) NOT NULL,
"auditInfo.createdBy" VARCHAR(50),
"auditInfo.createdOn" DATETIME,
"auditInfo.modifiedBy" VARCHAR(50),
"auditInfo.modifiedOn" DATETIME,
"auditInfo.requestedBy" VARCHAR(50),
"auditInfo.modifiedReasonCode" NVARCHAR(50),
"auditInfo.channel" NVARCHAR(50),
"parents" NVARCHAR(255),
"propMethod" NVARCHAR(50),
PRIMARY KEY (
"varietyId"
)
);

--ET.Entity

CREATE TABLE DS.ET.Entity(
"entityId" VARCHAR(50) NOT NULL,
"externalSystemId" VARCHAR(50),
"entityType" NVARCHAR(50) NOT NULL,
"status" NVARCHAR(50) NOT NULL,
"name" NVARCHAR(255) NOT NULL,
"coordinates.longX" DOUBLE PRECISION,
"coordinates.latY" DOUBLE PRECISION,
"altZ" DOUBLE PRECISION,
"nestleOwned" TINYINT ,
"ownershipType" NVARCHAR(50),
"geoNodeId" VARCHAR(50),
"foundationYear" INTEGER ,
"AAAEntryYear" INTEGER ,
"relationshipDate" datetime,
"nurseryOnSite" TINYINT ,
"millOnSite" TINYINT ,
"displayPermissionOK" TINYINT ,
"auditInfo.createdBy" VARCHAR(50),
"auditInfo.createdOn" datetime,
"auditInfo.modifiedBy" VARCHAR(50),
"auditInfo.modifiedOn" datetime,
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
"locationVerified" TINYINT ,
"geoStatus" NVARCHAR(50),
"inactivatedOn" datetime,
"AAAEnrolmentDate" datetime,
"AAAStatus" NVARCHAR(50),
"4CStatus" NVARCHAR(50),
"openQuantity" INTEGER ,
"registrationNo" NVARCHAR(50),
"managingEntity" NVARCHAR(255),
"mainActivity" NVARCHAR(50),
"verificationType" NVARCHAR(50),
"completionDate" datetime,
"isPartOfAgripreneurship" NVARCHAR(50),
"subEntityType" NVARCHAR(50) ,
PRIMARY KEY (
"entityId"
)
);

---CT.GeoNode

CREATE TABLE DS.CT.GeoNode ("geoNodeId" VARCHAR(50) NOT NULL ,
"geoNodeType" NVARCHAR(50) NOT NULL ,
"parentId" VARCHAR(50),
"isLeaf" TINYINT ,
"status" NVARCHAR(50) NOT NULL ,
"auditInfo.createdBy" VARCHAR(50),
"auditInfo.createdOn" datetime,
"auditInfo.modifiedBy" VARCHAR(50),
"auditInfo.modifiedOn" datetime,
"auditInfo.requestedBy" VARCHAR(50),
"auditInfo.modifiedReasonCode" NVARCHAR(50),
"auditInfo.channel" NVARCHAR(50),
"activationDate" datetime,
"name" NVARCHAR(255) NOT NULL ,
"countryCode" NVARCHAR(50),
"currencyCode" NVARCHAR(50),
"lineOfBusiness" NVARCHAR(50),
"shape" NVARCHAR(50),
PRIMARY KEY ("geoNodeId"));

