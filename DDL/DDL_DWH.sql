--AT_Observation
IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dwh].[AT_Observation]') AND type in ('U'))

BEGIN
CREATE TABLE [dwh].[AT_Observation] (
    [observationId]                VARCHAR (50)   NOT NULL,
    [status]                       NVARCHAR (50)  NULL,
    [type]                         NVARCHAR (50)  NULL,
    [obsDateTime]                  DATETIME2 (0)  NULL,
    [entityId]                     VARCHAR (50)   NULL,
    [criteriaId]                   VARCHAR (50)   NOT NULL,
    [interactionId]                VARCHAR (50)   NOT NULL,
    [parentObservationId]          VARCHAR (50)   NULL,
    [notApplicableFlag]            TINYINT DEFAULT 0,
    [riskyFlag]                    TINYINT DEFAULT 0,
    [answerType]                   NVARCHAR (50)  NULL,
    [answerDate]                   DATETIME2 (0)  NULL,
    [answerDate2]                  DATETIME2 (0)  NULL,
    [answerText]                   NVARCHAR (MAX) NULL,
    [answerNumber]                 FLOAT (53)     NULL,
    [unitOfMeasure]                NVARCHAR (50)  NULL,
    [currencyCode]                 NVARCHAR (50)  NULL,
    [comments]                     NVARCHAR (MAX) NULL,
    [correctiveActions]            NVARCHAR (MAX) NULL,
    [notes]                        NVARCHAR (MAX) NULL,
    [auditInfo.createdBy]          VARCHAR (50)   NULL,
    [auditInfo.createdOn]          DATETIME2 (7)  NULL,
    [auditInfo.modifiedBy]         VARCHAR (50)   NULL,
    [auditInfo.modifiedOn]         DATETIME2 (7)  NULL,
    [auditInfo.requestedBy]        VARCHAR (50)   NULL,
    [auditInfo.modifiedReasonCode] NVARCHAR (50)  NULL,
    [auditInfo.channel]            NVARCHAR (50)  NULL,
    [answerCode]                   NVARCHAR (50)  NULL,
    [isLatest]                     TINYINT DEFAULT 0,
    [isLatestByYear]               TINYINT DEFAULT 0,
    [obsDateOnly]                  DATE NULL,
    PRIMARY KEY CLUSTERED ([observationId] ASC)
) 
END;

--CT_GeoNode
IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dwh].[CT_GeoNode]') AND type in ('U'))

BEGIN
CREATE TABLE [dwh].[CT_GeoNode] (
    [geoNodeId]                    VARCHAR (50)   NOT NULL,
    [geoNodeType]                  NVARCHAR (50)  NOT NULL,
    [parentId]                     VARCHAR (50)   NULL,
    [isLeaf]                       TINYINT DEFAULT 0,
    [status]                       NVARCHAR (50)  NOT NULL,
    [auditInfo.createdBy]          VARCHAR (50)   NULL,
    [auditInfo.createdOn]          DATETIME       NULL,
    [auditInfo.modifiedBy]         VARCHAR (50)   NULL,
    [auditInfo.modifiedOn]         DATETIME       NULL,
    [auditInfo.requestedBy]        VARCHAR (50)   NULL,
    [auditInfo.modifiedReasonCode] NVARCHAR (50)  NULL,
    [auditInfo.channel]            NVARCHAR (50)  NULL,
    [activationDate]               DATETIME       NULL,
    [name]                         NVARCHAR (255) NOT NULL,
    [countryCode]                  NVARCHAR (50)  NULL,
    [currencyCode]                 NVARCHAR (50)  NULL,
    [lineOfBusiness]               NVARCHAR (50)  NULL,
    [shape]                        NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([geoNodeId] ASC)
) 
END;

--ET_Entity
IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dwh].[ET_Entity]') AND type in ('U'))

BEGIN
CREATE TABLE [dwh].[ET_Entity] (
    [entityId]                     VARCHAR (50)   NOT NULL,
    [externalSystemId]             VARCHAR (50)   NULL,
    [entityType]                   NVARCHAR (50)  NOT NULL,
    [status]                       NVARCHAR (50)  NOT NULL,
    [name]                         NVARCHAR (255) NOT NULL,
    [coordinates.longX]            FLOAT (53)     NULL,
    [coordinates.latY]             FLOAT (53)     NULL,
    [altZ]                         FLOAT (53)     NULL,
    [nestleOwned]                  TINYINT DEFAULT 0,
    [ownershipType]                NVARCHAR (50)  NULL,
    [geoNodeId]                    VARCHAR (50)   NULL,
    [foundationYear]               INT        NULL,
    [AAAEntryYear]                 INT        NULL,
    [relationshipDate]             DATETIME,
    [nurseryOnSite]                TINYINT DEFAULT 0,
    [millOnSite]                   TINYINT DEFAULT 0,
    [displayPermissionOK]          TINYINT DEFAULT 0,
    [auditInfo.createdBy]          VARCHAR (50)   NULL,
    [auditInfo.createdOn]          DATETIME       NULL,
    [auditInfo.modifiedBy]         VARCHAR (50)   NULL,
    [auditInfo.modifiedOn]         DATETIME       NULL,
    [auditInfo.requestedBy]        VARCHAR (50)   NULL,
    [auditInfo.modifiedReasonCode] NVARCHAR (50)  NULL,
    [auditInfo.channel]            NVARCHAR (50)  NULL,
    [addressInfo.address1]         NVARCHAR (255) NULL,
    [addressInfo.address2]         NVARCHAR (255) NULL,
    [addressInfo.city]             NVARCHAR (255) NULL,
    [addressInfo.district]         NVARCHAR (255) NULL,
    [addressInfo.province]         NVARCHAR (255) NULL,
    [addressInfo.zipcode]          NVARCHAR (255) NULL,
    [addressInfo.countryCode]      NVARCHAR (50)  NULL,
    [locationVerified]             TINYINT DEFAULT 0,
    [geoStatus]                    NVARCHAR (50)  NULL,
    [inactivatedOn]                DATETIME       NULL,
    [AAAEnrolmentDate]             DATETIME       NULL,
    [AAAStatus]                    NVARCHAR (50)  NULL,
    [4CStatus]                     NVARCHAR (50)  NULL,
    [openQuantity]                 INT            NULL,
    [registrationNo]               NVARCHAR (50)  NULL,
    [managingEntity]               NVARCHAR (255) NULL,
    [mainActivity]                 NVARCHAR (50)  NULL,
    [verificationType]             NVARCHAR (50)  NULL,
    [completionDate]               DATETIME       NULL,
    [isPartOfAgripreneurship]      NVARCHAR (50)  NULL,
    [subEntityType]                NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([entityId] ASC)
) 
END;

--IT_Interaction
IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dwh].[IT_Interaction]') AND type in ('U'))

BEGIN
CREATE TABLE [dwh].[IT_Interaction] (
    [interactionId]                VARCHAR (50)    NOT NULL,
    [type]                         NVARCHAR (50)   NULL,
    [name]                         NVARCHAR (255)  NULL,
    [notes]                        NVARCHAR (4000) NULL,
    [location]                     NVARCHAR (4000) NULL,
    [status]                       NVARCHAR (50)   NULL,
    [entityId]                     VARCHAR (50)    NULL,
    [employeeId]                   VARCHAR (50)    NULL,
    [eventId]                      VARCHAR (50)    NULL,
    [varietyTrialId]               VARCHAR (50)    NULL,
    [siteTrialId]                  VARCHAR (50)    NULL,
    [personId]                     VARCHAR (50)    NULL,
    [templateId]                   VARCHAR (50)    NULL,
    [startDate]                    DATETIME        NULL,
    [endDate]                      DATETIME        NULL,
    [geoNodeId]                    VARCHAR (50)    NULL,
    [organisationId]               VARCHAR (50)    NOT NULL,
    [auditInfo.createdBy]          VARCHAR (50)    NULL,
    [auditInfo.createdOn]          DATETIME2 (7)   NULL,
    [auditInfo.modifiedBy]         VARCHAR (50)    NULL,
    [auditInfo.modifiedOn]         DATETIME2 (7)   NULL,
    [auditInfo.requestedBy]        VARCHAR (50)    NULL,
    [auditInfo.modifiedReasonCode] NVARCHAR (50)   NULL,
    [auditInfo.channel]            NVARCHAR (50)   NULL,
    [correctiveActions]            NVARCHAR (4000) NULL,
    [movementId]                   VARCHAR (50)    NULL,
    [transactionId]                VARCHAR (50)    NULL,
    [startDateOnly]                DATE            NULL,
    PRIMARY KEY CLUSTERED ([interactionId] ASC)
) 
END;

--PT_Movement
IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dwh].[PT_Movement]') AND type in ('U'))

BEGIN
CREATE TABLE [dwh].[PT_Movement] (
    [movementId]                    VARCHAR (50)   NOT NULL,
    [type]                          NVARCHAR (50)  NULL,
    [status]                        NVARCHAR (50)  NULL,
    [varietyId]                     VARCHAR (50)   NULL,
    [propagationMethod]             NVARCHAR (50)  NULL,
    [shipmentIdentifier]            NVARCHAR (255) NULL,
    [startEntityId]                 VARCHAR (50)   NOT NULL,
    [endEntityId]                   VARCHAR (50)   NOT NULL,
    [senderId]                      VARCHAR (50)   NULL,
    [sentOn]                        DATETIME   NULL,
    [sentQty]                       INT            NULL,
    [receiverId]                    VARCHAR (50)   NULL,
    [receivedOn]                    DATETIME   NULL,
    [receivedQty]                   INT            NULL,
    [price.amount]                  VARCHAR (50)   NULL,
    [price.currencyCode]            NVARCHAR (50)  NULL,
    [costOfProduction.amount]       VARCHAR (50)   NULL,
    [costOfProduction.currencyCode] NVARCHAR (50)  NULL,
    [auditInfo.createdBy]           VARCHAR (50)   NULL,
    [auditInfo.createdOn]           DATETIME  NULL,
    [auditInfo.modifiedBy]          VARCHAR (50)   NULL,
    [auditInfo.modifiedOn]          DATETIME   NULL,
    [auditInfo.requestedBy]         VARCHAR (50)   NULL,
    [auditInfo.modifiedReasonCode]  NVARCHAR (50)  NULL,
    [auditInfo.channel]             NVARCHAR (50)  NULL,
    [lossReason]                    NVARCHAR (50)  NULL,
    [distributionPurpose]           NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([movementId] ASC)
) 
END;

--PT_Variety
IF  NOT EXISTS (SELECT * FROM sys.objects 
WHERE object_id = OBJECT_ID(N'[dwh].[PT_Variety]') AND type in ('U'))

BEGIN
CREATE TABLE [dwh].[PT_Variety] (
    [varietyId]                    VARCHAR (50)   NOT NULL,
    [name]                         NVARCHAR (255) NULL,
    [referenceNumber]              NVARCHAR (50)  NULL,
    [genericFlag]                  TINYINT DEFAULT 0,
    [genericVarietyId]             VARCHAR (50)   NULL,
    [status]                       NVARCHAR (50)  NULL,
    [species]                      NVARCHAR (50)  NULL,
    [origin]                       NVARCHAR (50)  NULL,
    [countryOfOrigin]              VARCHAR (50)   NULL,
    [geneticStatus]                NVARCHAR (50)  NULL,
    [arabicaShape]                 NVARCHAR (50)  NULL,
    [molecularSignature]           TINYINT DEFAULT 0,
    [organisationId]               VARCHAR (50)   NOT NULL,
    [auditInfo.createdBy]          VARCHAR (50)   NULL,
    [auditInfo.createdOn]          DATETIME       NULL,
    [auditInfo.modifiedBy]         VARCHAR (50)   NULL,
    [auditInfo.modifiedOn]         DATETIME       NULL,
    [auditInfo.requestedBy]        VARCHAR (50)   NULL,
    [auditInfo.modifiedReasonCode] NVARCHAR (50)  NULL,
    [auditInfo.channel]            NVARCHAR (50)  NULL,
    [parents]                      NVARCHAR (255) NULL,
    [propMethod]                   NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([varietyId] ASC)
) 
END;

