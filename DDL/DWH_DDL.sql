-- 1
CREATE TABLE dwh.AT_Criteria (
	criteriaId VARCHAR(50) NOT NULL
	,externalId NVARCHAR(50)
	,type NVARCHAR(50)
	,activityType NVARCHAR(50)
	,status NVARCHAR(50)
	,startDate DATETIME2(0)
	,endDate DATETIME2(0)
	,complianceDeadline INT
	,repeatAfter INT
	,classification1 NVARCHAR(50)
	,classification2 NVARCHAR(50)
	,classification3 NVARCHAR(50)
	,complianceFlag TINYINT
	,answerType NVARCHAR(50)
	,answerPrecision INT
	,answerMin FLOAT(53)
	,answerMax FLOAT(53)
	,answerInterval FLOAT(53)
	,answerConstrainUOM TINYINT
	,answerListSetId NVARCHAR(50)
	,allowNA TINYINT
	,allowRisky TINYINT DEFAULT 0
	,parentCriteriaId VARCHAR(50)
	,sortOrder INT
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,organisationId VARCHAR(50)
	,presentationType NVARCHAR(50)
	,applicableToMillOnSite TINYINT DEFAULT 0
	,applicableToNurseryOnSite TINYINT DEFAULT 0
	,ruleId VARCHAR(50)
	,iconType NVARCHAR(50)
	,PRIMARY KEY (criteriaId)
	);

--2
CREATE TABLE dwh.AT_CriteriaCost (
	criteriaId VARCHAR(50) NOT NULL
	,geoNodeId VARCHAR(50) NOT NULL
	,year INT NOT NULL
	,cosT_amount FLOAT(53)
	,cosT_currencyCode NVARCHAR(50)
	,status NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (
		criteriaId
		,geoNodeId
		,year
		)
	);

--3
CREATE TABLE dwh.AT_CriteriaTip (
	criteriaId VARCHAR(50) NOT NULL
	,geoNodeId VARCHAR(50) NOT NULL
	,text NVARCHAR(max)
	,PRIMARY KEY (
		criteriaId
		,geoNodeId
		)
	);

--4
CREATE TABLE dwh.AT_CriteriaToCriteriaGroup (
	criteriaId VARCHAR(50) NOT NULL
	,groupCode NVARCHAR(50) NOT NULL
	,criteriaEvaluationContext NVARCHAR(50)
	,PRIMARY KEY (
		criteriaId
		,groupCode
		)
	);

--5
CREATE TABLE dwh.AT_CriteriaToEntityType (
	criteriaId VARCHAR(50) NOT NULL
	,entityType NVARCHAR(50) NOT NULL
	,PRIMARY KEY (
		criteriaId
		,entityType
		)
	);

--6
CREATE TABLE dwh.AT_CriteriaToTopic (
	criteriaId VARCHAR(50) NOT NULL
	,topicCode NVARCHAR(50) NOT NULL
	,PRIMARY KEY (
		criteriaId
		,topicCode
		)
	);

--7
CREATE TABLE dwh.AT_CriteriaToUOM (
	criteriaId VARCHAR(50) NOT NULL
	,uomSetId NVARCHAR(50) NOT NULL
	,uomItemCode NVARCHAR(50) NOT NULL
	,PRIMARY KEY (
		criteriaId
		,uomSetId
		,uomItemCode
		)
	);

--8
CREATE TABLE dwh.AT_Criteria_History (
	auditDate DATETIME2(7) NOT NULL
	,action NVARCHAR(50)
	,auditChangedBy NVARCHAR(50)
	,criteriaId VARCHAR(50) NOT NULL
	,externalId NVARCHAR(50)
	,type NVARCHAR(50)
	,activityType NVARCHAR(50)
	,status NVARCHAR(50)
	,startDate DATETIME2(0)
	,endDate DATETIME2(0)
	,complianceDeadline INT
	,repeatAfter INT
	,classification1 NVARCHAR(50)
	,classification2 NVARCHAR(50)
	,classification3 NVARCHAR(50)
	,complianceFlag TINYINT
	,answerType NVARCHAR(50)
	,answerPrecision INT
	,answerMin FLOAT(53)
	,answerMax FLOAT(53)
	,answerInterval FLOAT(53)
	,answerConstrainUOM TINYINT
	,answerListSetId NVARCHAR(50)
	,allowNA TINYINT
	,allowRisky TINYINT DEFAULT 0
	,parentCriteriaId VARCHAR(50)
	,sortOrder INT
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,organisationId VARCHAR(50)
	,presentationType NVARCHAR(50)
	,applicableToMillOnSite TINYINT DEFAULT 0
	,applicableToNurseryOnSite TINYINT DEFAULT 0
	,ruleId VARCHAR(50)
	,iconType NVARCHAR(50)
	,PRIMARY KEY (
		auditDate
		,criteriaId
		)
	);

--9
CREATE TABLE dwh.AT_Criteria_Txt (
	criteriaId VARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,title NVARCHAR(255)
	,shortDescription NVARCHAR(3000)
	,longDescription NVARCHAR(max)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (
		criteriaId
		,language
		)
	);

--10
CREATE TABLE dwh.AT_Criteria_Txt_History (
	auditDate DATETIME2(7) NOT NULL
	,action NVARCHAR(50)
	,auditChangedBy NVARCHAR(50)
	,criteriaId VARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,title NVARCHAR(255)
	,shortDescription NVARCHAR(3000)
	,longDescription NVARCHAR(max)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (
		auditDate
		,criteriaId
		,language
		)
	);

--11
CREATE TABLE dwh.AT_Observation (
	observationId VARCHAR(50) NOT NULL
	,status NVARCHAR(50)
	,type NVARCHAR(50)
	,obsDateTime DATETIME2(0)
	,entityId VARCHAR(50)
	,criteriaId VARCHAR(50) NOT NULL
	,interactionId VARCHAR(50) NOT NULL
	,parentObservationId VARCHAR(50)
	,notApplicableFlag TINYINT
	,riskyFlag TINYINT
	,answerType NVARCHAR(50)
	,answerDate DATETIME2(0)
	,answerDate2 DATETIME2(0)
	,answerText NVARCHAR(max)
	,answerNumber FLOAT(53)
	,unitOfMeasure NVARCHAR(50)
	,currencyCode NVARCHAR(50)
	,comments NVARCHAR(max)
	,correctiveActions NVARCHAR(max)
	,notes NVARCHAR(max)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,answerCode NVARCHAR(50)
	,isLatest TINYINT DEFAULT 0
	,isLatestByYear TINYINT DEFAULT 0
	,obsDateOnly DATE
	,PRIMARY KEY (observationId)
	);

--12
CREATE TABLE dwh.AT_Observation_History (
	auditDate DATETIME2(7) NOT NULL
	,action NVARCHAR(50)
	,auditChangedBy NVARCHAR(50)
	,observationId VARCHAR(50) NOT NULL
	,status NVARCHAR(50)
	,type NVARCHAR(50)
	,obsDateTime DATETIME2(0)
	,entityId VARCHAR(50)
	,criteriaId VARCHAR(50) NOT NULL
	,interactionId VARCHAR(50) NOT NULL
	,parentObservationId VARCHAR(50)
	,notApplicableFlag TINYINT
	,riskyFlag TINYINT
	,answerType NVARCHAR(50)
	,answerDate DATETIME2(0)
	,answerDate2 DATETIME2(0)
	,answerText NVARCHAR(max)
	,answerNumber FLOAT(53)
	,unitOfMeasure NVARCHAR(50)
	,currencyCode NVARCHAR(50)
	,comments NVARCHAR(max)
	,correctiveActions NVARCHAR(max)
	,notes NVARCHAR(max)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,answerCode NVARCHAR(50)
	,isLatest TINYINT DEFAULT 0
	,isLatestByYear TINYINT DEFAULT 0
	,obsDateOnly DATE
	,PRIMARY KEY (
		auditDate
		,observationId
		)
	);

--13
CREATE TABLE dwh.AT_Section (
	sectionId NVARCHAR(50) NOT NULL
	,templateId VARCHAR(50)
	,status NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (sectionId)
	);

--14
CREATE TABLE dwh.AT_Section_Txt (
	sectionId VARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,title NVARCHAR(255)
	,description NVARCHAR(3000)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (
		sectionId
		,language
		)
	);

--15
CREATE TABLE dwh.AT_SelectedListAnswer (
	observationId VARCHAR(50) NOT NULL
	,selectedCode NVARCHAR(50) NOT NULL
	,PRIMARY KEY (
		observationId
		,selectedCode
		)
	);

--16
CREATE TABLE dwh.AT_Template (
	templateId VARCHAR(50) NOT NULL
	,status NVARCHAR(50)
	,type NVARCHAR(50)
	,applyToAllGeoNodes TINYINT
	,applyToAllOrgs TINYINT
	,activityType NVARCHAR(50)
	,startDate DATETIME2(0)
	,endDate DATETIME2(0)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,applyToAllSuppliers TINYINT
	,applyToAllPartners TINYINT
	,applyToAllCertPartners TINYINT
	,organisationId VARCHAR(50)
	,completionMandatory TINYINT DEFAULT 0
	,allowPrefill TINYINT DEFAULT 1
	,isPDF TINYINT DEFAULT 0
	,folderName NVARCHAR(255)
	,reviewSummarySetId NVARCHAR(50)
	,PRIMARY KEY (templateId)
	);

--17
CREATE TABLE dwh.AT_TemplateToCriteria (
	criteriaId VARCHAR(50) NOT NULL
	,templateId VARCHAR(50) NOT NULL
	,sortOrder FLOAT(53)
	,sectionId VARCHAR(50)
	,sortOrderSection INT
	,PRIMARY KEY (
		criteriaId
		,templateId
		)
	);

--18
CREATE TABLE dwh.AT_TemplateToCriteriaBranching (
	criteriaId VARCHAR(50) NOT NULL
	,templateId VARCHAR(50) NOT NULL
	,parentCriteriaId VARCHAR(50) NOT NULL
	,branchingValue NVARCHAR(50) NOT NULL
	,rootCriteriaId VARCHAR(50)
	,sortOrder FLOAT(53)
	,PRIMARY KEY (
		criteriaId
		,templateId
		,parentCriteriaId
		,branchingValue
		)
	);

--19
CREATE TABLE dwh.AT_TemplateToGeoNode (
	templateId VARCHAR(50) NOT NULL
	,geoNodeId VARCHAR(50) NOT NULL
	,PRIMARY KEY (
		templateId
		,geoNodeId
		)
	);

--20
CREATE TABLE dwh.AT_TemplateToGroup (
	templateId VARCHAR(50) NOT NULL
	,groupId VARCHAR(50) NOT NULL
	,PRIMARY KEY (
		templateId
		,groupId
		)
	);

--21
CREATE TABLE dwh.AT_TemplateToOrg (
	templateId VARCHAR(50) NOT NULL
	,organisationId VARCHAR(50) NOT NULL
	,PRIMARY KEY (
		templateId
		,organisationId
		)
	);

--22
CREATE TABLE dwh.AT_Template_Txt (
	templateId VARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,title NVARCHAR(255)
	,description NVARCHAR(3000)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (
		templateId
		,language
		)
	);

--23
CREATE TABLE dwh.AT_UOMToGeoNode (
	uomSetId NVARCHAR(50) NOT NULL
	,uomItemCode NVARCHAR(50) NOT NULL
	,geoNodeId VARCHAR(50) NOT NULL
	,PRIMARY KEY (
		uomSetId
		,uomItemCode
		,geoNodeId
		)
	);

--24
CREATE TABLE dwh.CT_Address (
	addressId VARCHAR(50) NOT NULL
	,type NVARCHAR(50)
	,country NVARCHAR(50)
	,address1 NVARCHAR(255)
	,address2 NVARCHAR(255)
	,city NVARCHAR(255)
	,district NVARCHAR(255)
	,province NVARCHAR(255)
	,zipcode NVARCHAR(255)
	,status NVARCHAR(50)
	,sortOrder INT
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (addressId)
	);

--25
CREATE TABLE dwh.CT_AppLog (
	logTime DATETIME2(0)
	,userName NVARCHAR(50)
	,userRole NVARCHAR(50)
	,organisation VARCHAR(50)
	,farms_DU_Version VARCHAR(50)
	,HANA_SPS_Version VARCHAR(50)
	,eventType NVARCHAR(50)
	,functionName NVARCHAR(50)
	,moduleName NVARCHAR(50)
	,logType NVARCHAR(50)
	,requestURL NVARCHAR(2000)
	,errorCode NVARCHAR(5)
	,logDescription NVARCHAR(1000)
	);

--26
CREATE TABLE dwh.CT_Configuration (
	configKey VARCHAR(50) NOT NULL
	,txtValue NVARCHAR(255)
	,numValue FLOAT(53)
	,dateValue DATETIME2(0)
	,spareField1 NVARCHAR(255)
	,comment NVARCHAR(255)
	,PRIMARY KEY (configKey)
	);

--27
CREATE TABLE dwh.CT_Employee (
	employeeId VARCHAR(50) NOT NULL
	,externalSystemId VARCHAR(50)
	,organisationId VARCHAR(50) NOT NULL
	,businessRole NVARCHAR(50)
	,status NVARCHAR(50)
	,userName NVARCHAR(50)
	,[personInfo.firstName] NVARCHAR(255)
	,[personInfo.lastName] NVARCHAR(255)
	,[personInfo.dateOfBirth] DATETIME2(0)
	,[personInfo.gender] NVARCHAR(50)
	,[personInfo.maritalStatus] NVARCHAR(50)
	,[contactInfo.email] NVARCHAR(100)
	,[contactInfo.mobilePhone] NVARCHAR(50)
	,[contactInfo.fixedPhone] NVARCHAR(50)
	,comment NVARCHAR(max)
	,languageCode NVARCHAR(2)
	,startDate DATETIME2(0)
	,endDate DATETIME2(0)
	,[addressInfo.address1] NVARCHAR(255)
	,[addressInfo.address2] NVARCHAR(255)
	,[addressInfo.city] NVARCHAR(255)
	,[addressInfo.district] NVARCHAR(255)
	,[addressInfo.province] NVARCHAR(255)
	,[addressInfo.zipcode] NVARCHAR(255)
	,[addressInfo.countryCode] NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,managerId VARCHAR(50)
	,PRIMARY KEY (employeeId)
	);

--28
CREATE TABLE dwh.CT_Employee_History (
	auditDate DATETIME2(7) NOT NULL
	,auditChangedBy NVARCHAR(50)
	,action NVARCHAR(50)
	,employeeId VARCHAR(50) NOT NULL
	,managerId VARCHAR(50)
	,externalSystemId VARCHAR(50)
	,organisationId VARCHAR(50) NOT NULL
	,businessRole NVARCHAR(50)
	,status NVARCHAR(50)
	,userName NVARCHAR(50)
	,[personInfo.firstName] NVARCHAR(255)
	,[personInfo.lastName] NVARCHAR(255)
	,[personInfo.dateOfBirth] DATETIME2(0)
	,[personInfo.gender] NVARCHAR(50)
	,[personInfo.maritalStatus] NVARCHAR(50)
	,[contactInfo.email] NVARCHAR(100)
	,[contactInfo.mobilePhone] NVARCHAR(50)
	,[contactInfo.fixedPhone] NVARCHAR(50)
	,comment NVARCHAR(max)
	,languageCode NVARCHAR(2)
	,startDate DATETIME2(0)
	,endDate DATETIME2(0)
	,[addressInfo.address1] NVARCHAR(255)
	,[addressInfo.address2] NVARCHAR(255)
	,[addressInfo.city] NVARCHAR(255)
	,[addressInfo.district] NVARCHAR(255)
	,[addressInfo.province] NVARCHAR(255)
	,[addressInfo.zipcode] NVARCHAR(255)
	,[addressInfo.countryCode] NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (
		auditDate
		,employeeId
		)
	);

--29
CREATE TABLE dwh.CT_GeoNode (
	geoNodeId VARCHAR(50) NOT NULL
	,geoNodeType NVARCHAR(50) NOT NULL
	,parentId VARCHAR(50)
	,isLeaf TINYINT
	,status NVARCHAR(50) NOT NULL
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,activationDate DATETIME2(0)
	,name NVARCHAR(255) NOT NULL
	,countryCode NVARCHAR(50)
	,currencyCode NVARCHAR(50)
	,lineOfBusiness NVARCHAR(50)
	,shape VARBINARY(max)
	,PRIMARY KEY (geoNodeId)
	);

--30
CREATE TABLE dwh.CT_GeoNodeInfo (
	geoNodeId VARCHAR(50) NOT NULL
	,month INT NOT NULL
	,year INT NOT NULL
	,raPercent FLOAT(53)
	,ponderation FLOAT(53)
	,ponderationCountry FLOAT(53)
	,premiumNespresso FLOAT(53)
	,premiumAAA FLOAT(53)
	,premiumRA FLOAT(53)
	,totalProduction FLOAT(53)
	,productionCost FLOAT(53)
	,price FLOAT(53)
	,status NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,aaaPercent FLOAT(53)
	,PRIMARY KEY (
		geoNodeId
		,month
		,year
		)
	);

--31
CREATE TABLE dwh.CT_GeoNode_Closure (
	parent VARCHAR(50) NOT NULL
	,child VARCHAR(50) NOT NULL
	,depth INT
	,PRIMARY KEY (
		parent
		,child
		)
	);

--32
CREATE TABLE dwh.CT_GeoNode_Txt (
	geoNodeId VARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,name NVARCHAR(255) NOT NULL
	,htmlContent NVARCHAR(max)
	,PRIMARY KEY (
		geoNodeId
		,language
		)
	);

--33
CREATE TABLE dwh.CT_KPIDetail (
	kpiId VARCHAR(50) NOT NULL
	,type NVARCHAR(50) NOT NULL
	,status NVARCHAR(50) DEFAULT 'ACTIVE' NOT NULL
	,controlType NVARCHAR(50)
	,isGroupRequired TINYINT DEFAULT 0
	,kpiSortType NVARCHAR(50)
	,isSortDescending TINYINT DEFAULT 0
	,PRIMARY KEY (kpiId)
	);

--34
CREATE TABLE dwh.CT_KPIDetail_Txt (
	kpiId VARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,title NVARCHAR(50)
	,PRIMARY KEY (
		kpiId
		,language
		)
	);

--35
CREATE TABLE dwh.CT_ListOption (
	setId VARCHAR(50) NOT NULL
	,itemCode NVARCHAR(50) NOT NULL
	,parentSetId VARCHAR(50)
	,parentItemCode VARCHAR(50)
	,status NVARCHAR(50) NOT NULL
	,sortOrder FLOAT(53)
	,complianceFlag TINYINT
	,score INT
	,color NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,organisationId VARCHAR(50) DEFAULT 'GLOBAL'
	,PRIMARY KEY (
		setId
		,itemCode
		)
	);

--36
CREATE TABLE dwh.CT_ListOptionValidityRule (
	setId VARCHAR(50) NOT NULL
	,itemCode VARCHAR(50) NOT NULL
	,param1 VARCHAR(50) NOT NULL
	,param2 VARCHAR(50) NOT NULL
	,PRIMARY KEY (
		setId
		,itemCode
		,param1
		,param2
		)
	);

--37
CREATE TABLE dwh.CT_ListOption_History (
	setId VARCHAR(50) NOT NULL
	,itemCode NVARCHAR(50) NOT NULL
	,parentSetId VARCHAR(50)
	,parentItemCode VARCHAR(50)
	,status NVARCHAR(50) NOT NULL
	,sortOrder FLOAT(53)
	,complianceFlag TINYINT
	,score INT
	,color NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,organisationId VARCHAR(50) DEFAULT 'GLOBAL'
	,PRIMARY KEY (
		setId
		,itemCode
		)
	);

--38
CREATE TABLE dwh.CT_ListOption_Txt (
	setId VARCHAR(50) NOT NULL
	,itemCode NVARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,label NVARCHAR(1000) NOT NULL
	,description NVARCHAR(3000)
	,PRIMARY KEY (
		setId
		,itemCode
		,language
		)
	);

--39
CREATE TABLE dwh.CT_ListOption_Txt_History (
	setId VARCHAR(50) NOT NULL
	,itemCode NVARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,label NVARCHAR(1000) NOT NULL
	,description NVARCHAR(3000)
	,PRIMARY KEY (
		setId
		,itemCode
		,language
		)
	);

--40
CREATE TABLE dwh.CT_ListSet (
	setId VARCHAR(50) NOT NULL
	,type NVARCHAR(50) NOT NULL
	,description NVARCHAR(255)
	,status NVARCHAR(50) DEFAULT 'ACTIVE' NOT NULL
	,allowOther TINYINT DEFAULT 0
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (setId)
	);

--41
CREATE TABLE dwh.CT_ListSet_History (
	setId VARCHAR(50) NOT NULL
	,type NVARCHAR(50) NOT NULL
	,description NVARCHAR(255)
	,status NVARCHAR(50) DEFAULT 'ACTIVE' NOT NULL
	,allowOther TINYINT DEFAULT 0
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (setId)
	);

--42
CREATE TABLE dwh.CT_MenuOption (
	menuId VARCHAR(50) NOT NULL
	,menuType VARCHAR(50) NOT NULL
	,parentMenuId VARCHAR(50)
	,status VARCHAR(50) NOT NULL
	,sortOrder FLOAT(53)
	,menuURL NVARCHAR(1000)
	,resolution VARCHAR(50)
	,layerType VARCHAR(100)
	,opacity FLOAT(53)
	,applicableToAllRoles TINYINT DEFAULT 0
	,wmsLayerInfo NVARCHAR(max)
	,webMapId NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (menuId)
	);

--43
CREATE TABLE dwh.CT_MenuOptionToRoles (
	menuId VARCHAR(50) NOT NULL
	,businessRole VARCHAR(50) NOT NULL
	,PRIMARY KEY (
		menuId
		,businessRole
		)
	);

--44
CREATE TABLE dwh.CT_MenuOption_Txt (
	menuId VARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,title NVARCHAR(255)
	,shortDescription NVARCHAR(255)
	,longDescription NVARCHAR(max)
	,PRIMARY KEY (
		menuId
		,language
		)
	);

--45
CREATE TABLE dwh.CT_NotificationConfig (
	notificationConfigId VARCHAR(50) NOT NULL
	,title NVARCHAR(50)
	,status NVARCHAR(50)
	,identifierType NVARCHAR(50)
	,sendToAgronomist TINYINT
	,sendTo1stManager TINYINT
	,sendTo2ndManager TINYINT
	,geoNodeId VARCHAR(50)
	,organisationId VARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (notificationConfigId)
	);

--46
CREATE TABLE dwh.CT_NotificationConfigMailText (
	notificationConfigId VARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,subject NVARCHAR(255)
	,body NVARCHAR(1000)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (
		notificationConfigId
		,language
		)
	);

--47
CREATE TABLE dwh.CT_NotificationConfigMultiListAnswer (
	configValueId VARCHAR(50) NOT NULL
	,configCode NVARCHAR(50) NOT NULL
	,PRIMARY KEY (
		configValueId
		,configCode
		)
	);

--48
CREATE TABLE dwh.CT_NotificationConfigRecipient (
	notificationConfigId VARCHAR(50) NOT NULL
	,employeeId VARCHAR(50) NOT NULL
	,type NVARCHAR(50) NOT NULL
	,PRIMARY KEY (
		notificationConfigId
		,employeeId
		,type
		)
	);

--49
CREATE TABLE dwh.CT_NotificationConfigValue (
	configValueId VARCHAR(50) NOT NULL
	,identifierKey NVARCHAR(50)
	,configType NVARCHAR(50)
	,notificationConfigId VARCHAR(50)
	,configComparison NVARCHAR(50)
	,configDate1 DATETIME2(0)
	,configDate2 DATETIME2(0)
	,configText NVARCHAR(255)
	,configNumber1 FLOAT(53)
	,configNumber2 FLOAT(53)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (configValueId)
	);

--50
CREATE TABLE dwh.CT_NotificationHistory (
	notificationId VARCHAR(50) NOT NULL
	,documentId VARCHAR(50)
	,notificationConfigId VARCHAR(50)
	,identifierType NVARCHAR(50)
	,identifierKey VARCHAR(50)
	,answer NVARCHAR(1000)
	,answerText NVARCHAR(1000)
	,answerDate DATETIME2(0)
	,answerNumber FLOAT(53)
	,status NVARCHAR(50)
	,geoNodeId VARCHAR(50)
	,organisationId VARCHAR(50)
	,configFlag TINYINT
	,comment NVARCHAR(1000)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,employeeId VARCHAR(50)
	,PRIMARY KEY (notificationId)
	);

--51
CREATE TABLE dwh.CT_NotificationHistoryMailText (
	notificationId VARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,subject NVARCHAR(255)
	,body NVARCHAR(1000)
	,PRIMARY KEY (
		notificationId
		,language
		)
	);

--52
CREATE TABLE dwh.CT_NotificationHistoryRecipient (
	notificationId VARCHAR(50) NOT NULL
	,employeeId VARCHAR(50) NOT NULL
	,type NVARCHAR(50) NOT NULL
	,isRead TINYINT
	,isDeleted TINYINT
	,PRIMARY KEY (
		notificationId
		,employeeId
		,type
		)
	);

--53
CREATE TABLE dwh.CT_Organisation (
	organisationId VARCHAR(50) NOT NULL
	,externalSystemId NVARCHAR(50)
	,businessUnitFlag TINYINT
	,adminUnitFlag TINYINT
	,organisationType NVARCHAR(50) NOT NULL
	,name NVARCHAR(255) NOT NULL
	,parentId VARCHAR(50)
	,activationDate DATETIME2(0)
	,coffeeForm NVARCHAR(50)
	,status NVARCHAR(50) NOT NULL
	,sortOrder INT
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,[addressInfo.address1] NVARCHAR(255)
	,[addressInfo.address2] NVARCHAR(255)
	,[addressInfo.city] NVARCHAR(255)
	,[addressInfo.district] NVARCHAR(255)
	,[addressInfo.province] NVARCHAR(255)
	,[addressInfo.zipcode] NVARCHAR(255)
	,[addressInfo.countryCode] NVARCHAR(50)
	,dilutionRate FLOAT(53)
	,productionUOM NVARCHAR(50)
	,lineOfBusiness NVARCHAR(50)
	,totalWomen INT
	,totalMen INT
	,PRIMARY KEY (organisationId)
	);

--54
CREATE TABLE dwh.CT_Organisation_Closure (
	parent VARCHAR(50) NOT NULL
	,child VARCHAR(50) NOT NULL
	,depth INT
	,PRIMARY KEY (
		parent
		,child
		)
	);

--55
CREATE TABLE dwh.CT_Organisation_History (
	auditDate DATETIME2(7) NOT NULL
	,auditChangedBy NVARCHAR(50)
	,action NVARCHAR(50)
	,organisationId VARCHAR(50) NOT NULL
	,externalSystemId NVARCHAR(50)
	,businessUnitFlag TINYINT
	,adminUnitFlag TINYINT
	,organisationType NVARCHAR(50) NOT NULL
	,name NVARCHAR(255) NOT NULL
	,parentId VARCHAR(50)
	,activationDate DATETIME2(0)
	,coffeeForm NVARCHAR(50)
	,status NVARCHAR(50) NOT NULL
	,sortOrder INT
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,[addressInfo.address1] NVARCHAR(255)
	,[addressInfo.address2] NVARCHAR(255)
	,[addressInfo.city] NVARCHAR(255)
	,[addressInfo.district] NVARCHAR(255)
	,[addressInfo.province] NVARCHAR(255)
	,[addressInfo.zipcode] NVARCHAR(255)
	,[addressInfo.countryCode] NVARCHAR(50)
	,dilutionRate FLOAT(53)
	,productionUOM NVARCHAR(50)
	,lineOfBusiness NVARCHAR(50)
	,totalWomen INT
	,totalMen INT
	,PRIMARY KEY (
		auditDate
		,organisationId
		)
	);

--56
CREATE TABLE dwh.CT_OrgToGeoNode (
	organisationId VARCHAR(50) NOT NULL
	,geoNodeId VARCHAR(50) NOT NULL
	,PRIMARY KEY (
		organisationId
		,geoNodeId
		)
	);

--57
CREATE TABLE dwh.CT_PerformanceTgt (
	performanceTgtId VARCHAR(50) NOT NULL
	,status NVARCHAR(50)
	,organisationId VARCHAR(50) NOT NULL
	,businessRole VARCHAR(50)
	,targetValue FLOAT(53)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,startDate DATETIME2(0)
	,endDate DATETIME2(0)
	,targetType NVARCHAR(50)
	,PRIMARY KEY (performanceTgtId)
	);

--58
CREATE TABLE dwh.CT_RuleConfigValue (
	ruleConfigId VARCHAR(50) NOT NULL
	,identifierKey NVARCHAR(50)
	,configType NVARCHAR(50)
	,ruleId VARCHAR(50)
	,oDataFilter NVARCHAR(1000)
	,collectionName NVARCHAR(50)
	,configComparison NVARCHAR(50)
	,configDate1 DATETIME2(0)
	,configDate2 DATETIME2(0)
	,configText NVARCHAR(255)
	,configNumber1 FLOAT(53)
	,configNumber2 FLOAT(53)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (ruleConfigId)
	);

--59
CREATE TABLE dwh.CT_RulesHeader (
	ruleId VARCHAR(50) NOT NULL
	,type NVARCHAR(50) NOT NULL
	,title NVARCHAR(255)
	,status NVARCHAR(50) NOT NULL
	,allOdataFilters NVARCHAR(1000)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (ruleId)
	);

--60
CREATE TABLE dwh.CT_UserKPIControl (
	controlId VARCHAR(50) NOT NULL
	,userDashboardId VARCHAR(50) NOT NULL
	,sectionId NVARCHAR(50) NOT NULL
	,controlType NVARCHAR(50) NOT NULL
	,targetValue DECIMAL(15, 5)
	,targetType NVARCHAR(50)
	,staticColour NVARCHAR(255)
	,sortOrder INT
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,myFarms TINYINT
	,PRIMARY KEY (controlId)
	);

--61
CREATE TABLE dwh.CT_UserKPIControl_Txt (
	controlId VARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,label NVARCHAR(255)
	,joinLabel NVARCHAR(255)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (
		controlId
		,language
		)
	);

--62
CREATE TABLE dwh.CT_UserKPIDashboard (
	userDashboardId VARCHAR(50) NOT NULL
	,organisationId VARCHAR(50) NOT NULL
	,businessRole NVARCHAR(50) NOT NULL
	,name NVARCHAR(255) NOT NULL
	,status NVARCHAR(50) DEFAULT 'ACTIVE' NOT NULL
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,type NVARCHAR(50)
	,layoutType NVARCHAR(50)
	,PRIMARY KEY (userDashboardId)
	);

--63
CREATE TABLE dwh.CT_UserSetting (
	userName NVARCHAR(50) NOT NULL
	,offlineMobileGroup VARCHAR(50)
	,helpEntityManagement TINYINT DEFAULT 1
	,helpMobile TINYINT DEFAULT 1
	,dashboardMarket TINYINT DEFAULT 1
	,dashboardAAACoffee TINYINT DEFAULT 1
	,dashboardTASQ TINYINT DEFAULT 1
	,areaUOM NVARCHAR(50) DEFAULT 'UOM_HECTAR'
	,weightUOM NVARCHAR(50) DEFAULT 'UOM_KILO'
	,userCurrency NVARCHAR(50) DEFAULT 'USD'
	,productionUOM NVARCHAR(50) DEFAULT 'UOM_KILO'
	,csvSeparator VARCHAR(50) DEFAULT ','
	,canSeeDeletedEntities NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,SyncInProgressTime DATETIME2(0)
	,SyncStartTime DATETIME2(0)
	,SyncEndTime DATETIME2(0)
	,csvUploadlanguage NVARCHAR(2)
	,PRIMARY KEY (userName)
	);

--64
CREATE TABLE dwh.CT_UserSetting_History (
	auditDate DATETIME2(7) NOT NULL
	,auditChangedBy NVARCHAR(50)
	,action NVARCHAR(50)
	,userName NVARCHAR(50) NOT NULL
	,offlineMobileGroup VARCHAR(50)
	,helpEntityManagement TINYINT DEFAULT 1
	,helpMobile TINYINT DEFAULT 1
	,dashboardMarket TINYINT DEFAULT 1
	,dashboardAAACoffee TINYINT DEFAULT 1
	,dashboardTASQ TINYINT DEFAULT 1
	,areaUOM NVARCHAR(50) DEFAULT 'UOM_HECTAR'
	,weightUOM NVARCHAR(50) DEFAULT 'UOM_KILO'
	,userCurrency NVARCHAR(50) DEFAULT 'USD'
	,productionUOM NVARCHAR(50) DEFAULT 'UOM_KILO'
	,csvSeparator VARCHAR(50) DEFAULT ','
	,canSeeDeletedEntities NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,SyncInProgressTime DATETIME2(0)
	,SyncStartTime DATETIME2(0)
	,SyncEndTime DATETIME2(0)
	,csvUploadlanguage NVARCHAR(2)
	,PRIMARY KEY (
		auditDate
		,userName
		)
	);

--65
CREATE TABLE dwh.DT_ActionComment_Tracking (
	actionId VARCHAR(50) NOT NULL
	,commentId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		actionId
		,commentId
		)
	);

--66
CREATE TABLE dwh.DT_ActionToTopic_Tracking (
	actionId VARCHAR(50) NOT NULL
	,topicCode NVARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		actionId
		,topicCode
		)
	);

--67
CREATE TABLE dwh.DT_Action_Tracking (
	actionId VARCHAR(50) NOT NULL
	,entityId VARCHAR(50)
	,groupId VARCHAR(50)
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (actionId)
	);

--68
CREATE TABLE dwh.DT_AdhocEvent_Tracking (
	adhocEventId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (adhocEventId)
	);

--69
CREATE TABLE dwh.DT_Attachment_Tracking (
	attachmentId VARCHAR(64) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,owningRecordId VARCHAR(50)
	,owningRecordType NVARCHAR(50)
	,PRIMARY KEY (attachmentId)
	);

--70
CREATE TABLE dwh.DT_CriteriaTip_Tracking (
	criteriaId VARCHAR(50) NOT NULL
	,geoNodeId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		criteriaId
		,geoNodeId
		)
	);

--71
CREATE TABLE dwh.DT_CriteriaToCriteriaGroup_Tracking (
	criteriaId VARCHAR(50) NOT NULL
	,groupCode NVARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		criteriaId
		,groupCode
		)
	);

--72
CREATE TABLE dwh.DT_CriteriaToEntityType_Tracking (
	criteriaId VARCHAR(50) NOT NULL
	,entityType NVARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		criteriaId
		,entityType
		)
	);

--73
CREATE TABLE dwh.DT_CriteriaToTopic_Tracking (
	criteriaId VARCHAR(50) NOT NULL
	,topicCode NVARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		criteriaId
		,topicCode
		)
	);

--74
CREATE TABLE dwh.DT_CriteriaToUOM_Tracking (
	criteriaId VARCHAR(50) NOT NULL
	,uomSetId NVARCHAR(50) NOT NULL
	,uomItemCode NVARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		criteriaId
		,uomSetId
		,uomItemCode
		)
	);

--75
CREATE TABLE dwh.DT_Criteria_Tracking (
	criteriaId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (criteriaId)
	);

--76
CREATE TABLE dwh.DT_Employee_Tracking (
	userName NVARCHAR(50) NOT NULL
	,organisationId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		userName
		,organisationId
		)
	);

--77
CREATE TABLE dwh.DT_EntityToEmployee_Tracking (
	entityId VARCHAR(50) NOT NULL
	,employeeId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		entityId
		,employeeId
		)
	);

--78
CREATE TABLE dwh.DT_EntityToEntity_Tracking (
	entityId VARCHAR(50) NOT NULL
	,relatedEntityId VARCHAR(50) NOT NULL
	,relationshipType NVARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		entityId
		,relatedEntityId
		,relationshipType
		)
	);

--79
CREATE TABLE dwh.DT_Entity_Tracking (
	entityId VARCHAR(50) NOT NULL
	,geoNodeId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		entityId
		,geoNodeId
		)
	);

--80
CREATE TABLE dwh.DT_EventToEmployee_Tracking (
	eventId VARCHAR(50) NOT NULL
	,employeeId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		eventId
		,employeeId
		)
	);

--81
CREATE TABLE dwh.DT_EventToPerson_Tracking (
	eventId VARCHAR(50) NOT NULL
	,personId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		eventId
		,personId
		)
	);

--82
CREATE TABLE dwh.DT_Event_Tracking (
	eventId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (eventId)
	);

--83
CREATE TABLE dwh.DT_GeoNode_Tracking (
	geoNodeId VARCHAR(50) NOT NULL
	,parentId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		geoNodeId
		,parentId
		)
	);

--84
CREATE TABLE dwh.DT_GroupToEmployee_Tracking (
	groupId VARCHAR(50) NOT NULL
	,employeeId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		groupId
		,employeeId
		)
	);

--85
CREATE TABLE dwh.DT_GroupToEntity_Tracking (
	groupId VARCHAR(50) NOT NULL
	,entityId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		groupId
		,entityId
		)
	);

--86
CREATE TABLE dwh.DT_Group_Tracking (
	groupId VARCHAR(50) NOT NULL
	,organisationId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		groupId
		,organisationId
		)
	);

--87
CREATE TABLE dwh.DT_OrgToGeoNode_Tracking (
	organisationId VARCHAR(50) NOT NULL
	,geoNodeId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		organisationId
		,geoNodeId
		)
	);

--88
CREATE TABLE dwh.DT_Organisation_Tracking (
	organisationId VARCHAR(50) NOT NULL
	,parentId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		organisationId
		,parentId
		)
	);

--89
CREATE TABLE dwh.DT_Person_Tracking (
	personId VARCHAR(50) NOT NULL
	,entityId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		personId
		,entityId
		)
	);

--90
CREATE TABLE dwh.DT_Plot_Tracking (
	plotId VARCHAR(50) NOT NULL
	,entityId VARCHAR(50)
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (plotId)
	);

--91
CREATE TABLE dwh.DT_RuleHeader_Tracking (
	ruleId VARCHAR(50) NOT NULL
	,type NVARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (ruleId)
	);

--92
CREATE TABLE dwh.DT_TemplateToCriteria_Tracking (
	templateId VARCHAR(50) NOT NULL
	,criteriaId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		templateId
		,criteriaId
		)
	);

--93
CREATE TABLE dwh.DT_TemplateToGeoNode_Tracking (
	templateId VARCHAR(50) NOT NULL
	,geoNodeId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		templateId
		,geoNodeId
		)
	);

--94
CREATE TABLE dwh.DT_TemplateToGroup_Tracking (
	templateId VARCHAR(50) NOT NULL
	,groupId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		templateId
		,groupId
		)
	);

--95
CREATE TABLE dwh.DT_TemplateToOrg_Tracking (
	templateId VARCHAR(50) NOT NULL
	,organisationId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		templateId
		,organisationId
		)
	);

--96
CREATE TABLE dwh.DT_Template_Tracking (
	templateId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (templateId)
	);

--97
CREATE TABLE dwh.DT_UOMToGeoNode_Tracking (
	uomSetId NVARCHAR(50) NOT NULL
	,uomItemCode NVARCHAR(50) NOT NULL
	,geoNodeId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		uomSetId
		,uomItemCode
		,geoNodeId
		)
	);

--98
CREATE TABLE dwh.DT_UserSetting_Tracking (
	userName VARCHAR(50) NOT NULL
	,offlineMobileGroup VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		userName
		,offlineMobileGroup
		)
	);

--99
CREATE TABLE dwh.DT_VarietyCountryToLOB_Tracking (
	varietyId VARCHAR(50) NOT NULL
	,geoNodeId VARCHAR(50) NOT NULL
	,lineOfBusiness NVARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		varietyId
		,geoNodeId
		,lineOfBusiness
		)
	);

--100
CREATE TABLE dwh.DT_VarietyToEntity_Tracking (
	varietyId VARCHAR(50) NOT NULL
	,entityId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		varietyId
		,entityId
		)
	);

--101
CREATE TABLE dwh.DT_VarietyToPlot_Tracking (
	varietyId VARCHAR(50) NOT NULL
	,plotId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (
		varietyId
		,plotId
		)
	);

--102
CREATE TABLE dwh.DT_Variety_Tracking (
	varietyId VARCHAR(50) NOT NULL
	,lastModified DATETIME2(7)
	,status NVARCHAR(50)
	,PRIMARY KEY (varietyId)
	);

--103
CREATE TABLE dwh.ET_Certification (
	certificationId VARCHAR(50) NOT NULL
	,entityId VARCHAR(50)
	,type NVARCHAR(50)
	,certificationDate DATETIME2(0)
	,certificationNumber NVARCHAR(50)
	,averageScore FLOAT(53)
	,status NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,certificationGroup VARCHAR(50)
	,certifiedBy VARCHAR(50)
	,certificationExpiryDate DATETIME2(0)
	,PRIMARY KEY (certificationId)
	);

--104
CREATE TABLE dwh.ET_CommodityPrice (
	dateOfPrice DATETIME2(0) NOT NULL
	,commodityType NVARCHAR(50) NOT NULL
	,price FLOAT(53)
	,islatest TINYINT DEFAULT 0
	,isClosingPrice TINYINT DEFAULT 0
	,PRIMARY KEY (
		dateOfPrice
		,commodityType
		)
	);

--105
CREATE TABLE dwh.ET_CommodityTransaction (
	transactionId VARCHAR(50) NOT NULL
	,commodityType NVARCHAR(50) DEFAULT 'COFFEE' NOT NULL
	,geoNodeId VARCHAR(50) NOT NULL
	,entityId VARCHAR(50)
	,entityExternalId VARCHAR(50)
	,transactionDate DATETIME2(0)
	,status NVARCHAR(50) DEFAULT 'ACTIVE' NOT NULL
	,[quantity.quantity] FLOAT(53)
	,[quantity.unitOfMeasure] NVARCHAR(50)
	,pointOfPurchase NVARCHAR(255)
	,pointOfPurchaseCode NVARCHAR(255)
	,invoiceNumber NVARCHAR(255)
	,nespressoContractNumber NVARCHAR(255)
	,containerNumber NVARCHAR(255)
	,dateOfEmbarkment DATETIME2(0)
	,usdExchangeRate FLOAT(53)
	,coffeeState NVARCHAR(50)
	,dilutionRate FLOAT(53)
	,[basePrice.amount] FLOAT(53)
	,[basePrice.currencyCode] NVARCHAR(50)
	,[totalBasePrice.amount] FLOAT(53)
	,[totalBasePrice.currencyCode] NVARCHAR(50)
	,[aaaPremiumPaid.amount] FLOAT(53)
	,[aaaPremiumPaid.currencyCode] NVARCHAR(50)
	,aaaFarmCertified TINYINT
	,[raPremiumPaid.amount] FLOAT(53)
	,[raPremiumPaid.currencyCode] NVARCHAR(50)
	,rainforestCertified TINYINT
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,coffeeSpecies NVARCHAR(50)
	,PRIMARY KEY (transactionId)
	);

--106
CREATE TABLE dwh.ET_Consent (
	consentId VARCHAR(50) NOT NULL
	,consentType VARCHAR(50) NOT NULL
	,entityId VARCHAR(50)
	,personId VARCHAR(50) NOT NULL
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (consentId)
	);

--107
CREATE TABLE dwh.ET_Entity (
	entityId VARCHAR(50) NOT NULL
	,externalSystemId VARCHAR(50)
	,entityType NVARCHAR(50) NOT NULL
	,status NVARCHAR(50) NOT NULL
	,name NVARCHAR(255) NOT NULL
	,[coordinates.longX] FLOAT(53)
	,[coordinates.latY] FLOAT(53)
	,altZ NVARCHAR(255)
	,nestleOwned TINYINT
	,ownershipType NVARCHAR(50)
	,geoNodeId VARCHAR(50)
	,foundationYear NVARCHAR(255)
	,AAAEntryYear NVARCHAR(255)
	,relationshipDate NVARCHAR(255)
	,nurseryOnSite NVARCHAR(255)
	,millOnSite TINYINT DEFAULT 0
	,displayPermissionOK TINYINT
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] NVARCHAR(255)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,[addressInfo.address1] NVARCHAR(255)
	,[addressInfo.address2] NVARCHAR(255)
	,[addressInfo.city] NVARCHAR(255)
	,[addressInfo.district] NVARCHAR(255)
	,[addressInfo.province] NVARCHAR(255)
	,[addressInfo.zipcode] NVARCHAR(255)
	,[addressInfo.countryCode] NVARCHAR(50)
	,locationVerified TINYINT
	,geoStatus NVARCHAR(50)
	,inactivatedOn DATETIME2(0)
	,AAAEnrolmentDate DATETIME2(0)
	,AAAStatus NVARCHAR(50)
	,[4CStatus] NVARCHAR(50)
	,openQuantity INT
	,registrationNo NVARCHAR(50)
	,managingEntity NVARCHAR(255)
	,mainActivity NVARCHAR(50)
	,verificationType NVARCHAR(50)
	,completionDate DATETIME2(0)
	,isPartOfAgripreneurship NVARCHAR(50)
	,subEntityType NVARCHAR(50) DEFAULT 'INTERNAL'
	,PRIMARY KEY (entityId)
	);

--108
CREATE TABLE dwh.ET_EntityGeoSpatial (
	entityId_geo VARCHAR(50) NOT NULL
	,entityGeoLocation VARBINARY(max)
	,PRIMARY KEY (entityId_geo)
	);

--109
CREATE TABLE dwh.ET_EntityToEmployee (
	entityId VARCHAR(50) NOT NULL
	,employeeId VARCHAR(50) NOT NULL
	,relationWithEntity NVARCHAR(50)
	,PRIMARY KEY (
		entityId
		,employeeId
		)
	);

--110
CREATE TABLE dwh.ET_EntityToEntity (
	entityId VARCHAR(50) NOT NULL
	,relatedEntityId VARCHAR(50) NOT NULL
	,relationshipType NVARCHAR(50) NOT NULL
	,PRIMARY KEY (
		entityId
		,relatedEntityId
		,relationshipType
		)
	);

--111
CREATE TABLE dwh.ET_EntityToEntity_History (
	auditDate DATETIME2(7) NOT NULL
	,auditChangedBy NVARCHAR(50)
	,action NVARCHAR(50)
	,entityId VARCHAR(50) NOT NULL
	,relatedEntityId VARCHAR(50) NOT NULL
	,relationshipType NVARCHAR(50) NOT NULL
	,PRIMARY KEY (
		auditDate
		,entityId
		,relatedEntityId
		,relationshipType
		)
	);

--112
CREATE TABLE dwh.ET_Entity_History (
	auditDate DATETIME2(7) NOT NULL
	,auditChangedBy NVARCHAR(50)
	,action NVARCHAR(50)
	,entityId VARCHAR(50) NOT NULL
	,externalSystemId VARCHAR(50)
	,entityType NVARCHAR(50) NOT NULL
	,status NVARCHAR(50) NOT NULL
	,name NVARCHAR(255) NOT NULL
	,[coordinates.longX] FLOAT(53)
	,[coordinates.latY] FLOAT(53)
	,altZ NVARCHAR(255)
	,nestleOwned TINYINT
	,ownershipType NVARCHAR(50)
	,geoNodeId VARCHAR(50)
	,foundationYear NVARCHAR(255)
	,AAAEntryYear NVARCHAR(255)
	,relationshipDate NVARCHAR(255)
	,nurseryOnSite NVARCHAR(255)
	,millOnSite TINYINT
	,displayPermissionOK TINYINT
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,[addressInfo.address1] NVARCHAR(255)
	,[addressInfo.address2] NVARCHAR(255)
	,[addressInfo.city] NVARCHAR(255)
	,[addressInfo.district] NVARCHAR(255)
	,[addressInfo.province] NVARCHAR(255)
	,[addressInfo.zipcode] NVARCHAR(255)
	,[addressInfo.countryCode] NVARCHAR(50)
	,locationVerified TINYINT
	,geoStatus NVARCHAR(50)
	,inactivatedOn DATETIME2(0)
	,AAAEnrolmentDate DATETIME2(0)
	,AAAStatus NVARCHAR(50)
	,[4CStatus] NVARCHAR(50)
	,openQuantity INT
	,registrationNo NVARCHAR(50)
	,managingEntity NVARCHAR(255)
	,mainActivity NVARCHAR(50)
	,verificationType NVARCHAR(50)
	,completionDate DATETIME2(0)
	,isPartOfAgripreneurship NVARCHAR(50)
	,subEntityType NVARCHAR(50) DEFAULT 'INTERNAL'
	,PRIMARY KEY (
		auditDate
		,entityId
		)
	);

--113
CREATE TABLE dwh.ET_Group (
	groupId VARCHAR(50) NOT NULL
	,externalSystemId VARCHAR(50)
	,organisationId VARCHAR(50) NOT NULL
	,type NVARCHAR(50) NOT NULL
	,name NVARCHAR(255) NOT NULL
	,description NVARCHAR(max)
	,[budget.amount] FLOAT(53)
	,[budget.currencyCode] NVARCHAR(50)
	,certificationType NVARCHAR(50)
	,certificationDate DATETIME2(0)
	,certificationExpiryDate DATETIME2(0)
	,certificationNumber NVARCHAR(50)
	,certificationAvgScore FLOAT(53)
	,certificationStatus NVARCHAR(50)
	,certifiedBy VARCHAR(50)
	,status NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,ruleId VARCHAR(50)
	,isDynamic TINYINT DEFAULT 0
	,PRIMARY KEY (groupId)
	);

--114
CREATE TABLE dwh.ET_GroupToEmployee (
	groupId VARCHAR(50) NOT NULL
	,employeeId VARCHAR(50) NOT NULL
	,PRIMARY KEY (
		groupId
		,employeeId
		)
	);

--115
CREATE TABLE dwh.ET_GroupToEntity (
	groupId VARCHAR(50) NOT NULL
	,entityId VARCHAR(50) NOT NULL
	,PRIMARY KEY (
		groupId
		,entityId
		)
	);

--116
CREATE TABLE dwh.ET_GroupToOrg (
	groupId VARCHAR(50) NOT NULL
	,organisationId VARCHAR(50) NOT NULL
	,PRIMARY KEY (
		groupId
		,organisationId
		)
	);

--117
CREATE TABLE dwh.ET_Group_History (
	auditDate DATETIME2(7) NOT NULL
	,auditChangedBy NVARCHAR(50)
	,action NVARCHAR(50)
	,groupId VARCHAR(50) NOT NULL
	,externalSystemId VARCHAR(50)
	,organisationId VARCHAR(50) NOT NULL
	,type NVARCHAR(50) NOT NULL
	,name NVARCHAR(255) NOT NULL
	,description NVARCHAR(max)
	,[budget.amount] FLOAT(53)
	,[budget.currencyCode] NVARCHAR(50)
	,certificationType NVARCHAR(50)
	,certificationDate DATETIME2(0)
	,certificationExpiryDate DATETIME2(0)
	,certificationNumber NVARCHAR(50)
	,certificationAvgScore FLOAT(53)
	,certificationStatus NVARCHAR(50)
	,certifiedBy VARCHAR(50)
	,status NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,ruleId VARCHAR(50)
	,isDynamic TINYINT
	,PRIMARY KEY (
		auditDate
		,groupId
		)
	);

--118
CREATE TABLE dwh.ET_Person (
	personId VARCHAR(50) NOT NULL
	,externalSystemId VARCHAR(50)
	,externalSystemId2 VARCHAR(50)
	,status NVARCHAR(50)
	,yearOfBirth INT
	,[personInfo.firstName] NVARCHAR(255)
	,[personInfo.lastName] NVARCHAR(255)
	,[personInfo.dateOfBirth] DATETIME2(0)
	,[personInfo.gender] NVARCHAR(50)
	,[personInfo.maritalStatus] NVARCHAR(50)
	,[contactInfo.email] NVARCHAR(100)
	,[contactInfo.mobilePhone] NVARCHAR(50)
	,[contactInfo.fixedPhone] NVARCHAR(50)
	,entityId VARCHAR(50) NOT NULL
	,primaryIndicator TINYINT
	,comment NVARCHAR(max)
	,yearStartedFarming INT
	,educationLevel NVARCHAR(50)
	,yearsOfSchooling INT
	,worksWithCoffee NVARCHAR(50)
	,relationToEntity NVARCHAR(50)
	,livesAt NVARCHAR(50)
	,deliversCoffee NVARCHAR(50)
	,pictureId VARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,[addressInfo.address1] NVARCHAR(255)
	,[addressInfo.address2] NVARCHAR(255)
	,[addressInfo.city] NVARCHAR(255)
	,[addressInfo.district] NVARCHAR(255)
	,[addressInfo.province] NVARCHAR(255)
	,[addressInfo.zipcode] NVARCHAR(255)
	,[addressInfo.countryCode] NVARCHAR(50)
	,PRIMARY KEY (personId)
	);

--119
CREATE TABLE dwh.ET_Person_History (
	auditDate DATETIME2(7) NOT NULL
	,auditChangedBy NVARCHAR(50)
	,action NVARCHAR(50)
	,personId VARCHAR(50) NOT NULL
	,externalSystemId VARCHAR(50)
	,externalSystemId2 VARCHAR(50)
	,status NVARCHAR(50)
	,yearOfBirth INT
	,[personInfo.firstName] NVARCHAR(255)
	,[personInfo.lastName] NVARCHAR(255)
	,[personInfo.dateOfBirth] DATETIME2(0)
	,[personInfo.gender] NVARCHAR(50)
	,[personInfo.maritalStatus] NVARCHAR(50)
	,[contactInfo.email] NVARCHAR(100)
	,[contactInfo.mobilePhone] NVARCHAR(50)
	,[contactInfo.fixedPhone] NVARCHAR(50)
	,entityId VARCHAR(50) NOT NULL
	,primaryIndicator TINYINT
	,comment NVARCHAR(max)
	,yearStartedFarming INT
	,educationLevel NVARCHAR(50)
	,yearsOfSchooling INT
	,worksWithCoffee NVARCHAR(50)
	,relationToEntity NVARCHAR(50)
	,livesAt NVARCHAR(50)
	,deliversCoffee NVARCHAR(50)
	,pictureId VARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,[addressInfo.address1] NVARCHAR(255)
	,[addressInfo.address2] NVARCHAR(255)
	,[addressInfo.city] NVARCHAR(255)
	,[addressInfo.district] NVARCHAR(255)
	,[addressInfo.province] NVARCHAR(255)
	,[addressInfo.zipcode] NVARCHAR(255)
	,[addressInfo.countryCode] NVARCHAR(50)
	,PRIMARY KEY (
		auditDate
		,personId
		)
	);

--120
CREATE TABLE dwh.ET_Plot (
	plotId VARCHAR(50) NOT NULL
	,entityId VARCHAR(50)
	,plotNumber VARCHAR(50)
	,varietyId VARCHAR(50)
	,[area.quantity] FLOAT(53)
	,[area.unitOfMeasure] NVARCHAR(50)
	,process NVARCHAR(50)
	,numTrees INT
	,numStemsPerTree INT
	,renovationPercent FLOAT(53)
	,replantPercent FLOAT(53)
	,rejunvenationPercent FLOAT(53)
	,averageAge INT
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,status NVARCHAR(50)
	,initialPlantingDate DATETIME2(0)
	,treesDensity INT
	,productivity INT
	,productivityUOM NVARCHAR(50)
	,PRIMARY KEY (plotId)
	);

--121
CREATE TABLE dwh.ET_Plot_History (
	auditChangedBy NVARCHAR(50)
	,action NVARCHAR(50)
	,auditDate DATETIME2(7) NOT NULL
	,plotId VARCHAR(50) NOT NULL
	,entityId VARCHAR(50)
	,plotNumber VARCHAR(50)
	,varietyId VARCHAR(50)
	,[area.quantity] FLOAT(53)
	,[area.unitOfMeasure] NVARCHAR(50)
	,process NVARCHAR(50)
	,numTrees INT
	,numStemsPerTree INT
	,renovationPercent FLOAT(53)
	,replantPercent FLOAT(53)
	,rejunvenationPercent FLOAT(53)
	,averageAge INT
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,status NVARCHAR(50)
	,initialPlantingDate DATETIME2(0)
	,treesDensity INT
	,productivity INT
	,productivityUOM NVARCHAR(50)
	,PRIMARY KEY (
		auditDate
		,plotId
		)
	);

--122
CREATE TABLE dwh.IT_Action (
	actionId VARCHAR(50) NOT NULL
	,description NVARCHAR(3000)
	,status NVARCHAR(50)
	,deadline DATETIME2(0)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,priority NVARCHAR(50)
	,entityId VARCHAR(50)
	,groupId VARCHAR(50)
	,PRIMARY KEY (actionId)
	);

--123
CREATE TABLE dwh.IT_ActionComment (
	actionId VARCHAR(50) NOT NULL
	,commentId VARCHAR(50) NOT NULL
	,createdOn DATETIME2(0)
	,comment NVARCHAR(3000)
	,replyTo VARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (
		actionId
		,commentId
		)
	);

--124
CREATE TABLE dwh.IT_ActionToTopic (
	actionId VARCHAR(50) NOT NULL
	,topicCode NVARCHAR(50) NOT NULL
	,PRIMARY KEY (
		actionId
		,topicCode
		)
	);

--125
CREATE TABLE dwh.IT_AdhocEvent (
	adhocEventId VARCHAR(50) NOT NULL
	,adhocEventType NVARCHAR(50)
	,status NVARCHAR(50)
	,name NVARCHAR(255)
	,description NVARCHAR(3000)
	,location NVARCHAR(3000)
	,startDate DATETIME2(0)
	,endDate DATETIME2(0)
	,organisationId VARCHAR(50) NOT NULL
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,entityId VARCHAR(50)
	,[coordinates.longX] FLOAT(53)
	,[coordinates.latY] FLOAT(53)
	,[addressInfo.address1] NVARCHAR(255)
	,[addressInfo.address2] NVARCHAR(255)
	,[addressInfo.city] NVARCHAR(255)
	,[addressInfo.district] NVARCHAR(255)
	,[addressInfo.province] NVARCHAR(255)
	,[addressInfo.zipcode] NVARCHAR(255)
	,[addressInfo.countryCode] NVARCHAR(50)
	,geoNodeId VARCHAR(50)
	,PRIMARY KEY (adhocEventId)
	);

--126
CREATE TABLE dwh.IT_AdhocEventToTopic (
	adhocEventId VARCHAR(50) NOT NULL
	,topicCode NVARCHAR(50) NOT NULL
	,PRIMARY KEY (
		adhocEventId
		,topicCode
		)
	);

--127
CREATE TABLE dwh.IT_Event (
	eventId VARCHAR(50) NOT NULL
	,eventType NVARCHAR(50)
	,status NVARCHAR(50)
	,name NVARCHAR(255)
	,description NVARCHAR(max)
	,location NVARCHAR(max)
	,startDate DATETIME2(0)
	,endDate DATETIME2(0)
	,organisationId VARCHAR(50) NOT NULL
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,externalId NVARCHAR(50)
	,PRIMARY KEY (eventId)
	);

--128
CREATE TABLE dwh.IT_EventToEmployee (
	eventId VARCHAR(50) NOT NULL
	,employeeId VARCHAR(50) NOT NULL
	,PRIMARY KEY (
		eventId
		,employeeId
		)
	);

--129
CREATE TABLE dwh.IT_EventToPerson (
	eventId VARCHAR(50) NOT NULL
	,personId VARCHAR(50) NOT NULL
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (
		eventId
		,personId
		)
	);

--130
CREATE TABLE dwh.IT_EventToTopic (
	eventId VARCHAR(50) NOT NULL
	,topicCode NVARCHAR(50) NOT NULL
	,PRIMARY KEY (
		eventId
		,topicCode
		)
	);

--131
CREATE TABLE dwh.IT_Interaction (
	interactionId VARCHAR(50) NOT NULL
	,type NVARCHAR(50)
	,name NVARCHAR(255)
	,notes NVARCHAR(max)
	,location NVARCHAR(max)
	,status NVARCHAR(50)
	,entityId VARCHAR(50)
	,employeeId VARCHAR(50)
	,eventId VARCHAR(50)
	,varietyTrialId VARCHAR(50)
	,siteTrialId VARCHAR(50)
	,personId VARCHAR(50)
	,templateId VARCHAR(50)
	,startDate DATETIME2(0)
	,endDate DATETIME2(0)
	,geoNodeId VARCHAR(50)
	,organisationId VARCHAR(50) NOT NULL
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,correctiveActions NVARCHAR(max)
	,movementId VARCHAR(50)
	,transactionId VARCHAR(50)
	,startDateOnly DATE
	,PRIMARY KEY (interactionId)
	);

--132
CREATE TABLE dwh.IT_InteractionToTopic (
	interactionId VARCHAR(50) NOT NULL
	,topicCode NVARCHAR(50) NOT NULL
	,PRIMARY KEY (
		interactionId
		,topicCode
		)
	);

--133
CREATE TABLE dwh.IT_Interaction_History (
	auditDate DATETIME2(7) NOT NULL
	,auditChangedBy NVARCHAR(50)
	,action NVARCHAR(50)
	,interactionId VARCHAR(50) NOT NULL
	,type NVARCHAR(50)
	,name NVARCHAR(255)
	,notes NVARCHAR(max)
	,location NVARCHAR(max)
	,status NVARCHAR(50)
	,entityId VARCHAR(50)
	,employeeId VARCHAR(50)
	,eventId VARCHAR(50)
	,varietyTrialId VARCHAR(50)
	,siteTrialId VARCHAR(50)
	,personId VARCHAR(50)
	,templateId VARCHAR(50)
	,startDate DATETIME2(0)
	,endDate DATETIME2(0)
	,geoNodeId VARCHAR(50)
	,organisationId VARCHAR(50) NOT NULL
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,correctiveActions NVARCHAR(max)
	,movementId VARCHAR(50)
	,transactionId VARCHAR(50)
	,startDateOnly DATE
	,PRIMARY KEY (
		auditDate
		,interactionId
		)
	);

--134
CREATE TABLE dwh.MT_DashboardGeneric (
	lineOfBusiness VARCHAR(50) NOT NULL
	,country VARCHAR(50) NOT NULL
	,cluster VARCHAR(50) NOT NULL
	,inThefieldVisit INT
	,tasqCompliance INT
	,tasqNonCompliance INT
	,aaaCoffeesource FLOAT(53)
	,aaaCoffee INT
	,coffeeNYMarketPrice FLOAT(53)
	,numberOfCountries INT
	,numberOfClusters INT
	,numberOfFarms INT
	,aaaCoffeeArea FLOAT(53)
	,totalProduction FLOAT(53)
	,numberOfAnswersInDB INT
	,male INT
	,female INT
	,totalAgronomist INT
	,noOfFarmsLand INT
	,numberOfTasq INT
	,PRIMARY KEY (
		lineOfBusiness
		,country
		,cluster
		)
	);

--135
CREATE TABLE dwh.MT_DashboardGenericNescafe (
	lineOfBusiness VARCHAR(50)
	,country VARCHAR(50)
	,license4CUnit NVARCHAR(50)
	,cluster VARCHAR(50)
	,inThefieldVisit INT
	,tasqCompliance INT
	,tasqNonCompliance INT
	,aaaCoffeesource FLOAT(53)
	,aaaCoffee INT
	,coffeeNYMarketPrice FLOAT(53)
	,numberOfCountries INT
	,numberOfClusters INT
	,numberOfFarms INT
	,aaaCoffeeArea FLOAT(53)
	,totalProduction FLOAT(53)
	,numberOfAnswersInDB INT
	,male INT
	,female INT
	,totalAgronomist INT
	,noOfFarmsLand INT
	,numberOfTasq INT
	,numberOf4CUnit INT
	,numberOf4CUnitFarms INT
	);

--136
CREATE TABLE dwh.MT_DashboardGenericYearly (
	lineOfBusiness VARCHAR(50) NOT NULL
	,country VARCHAR(50) NOT NULL
	,cluster VARCHAR(50) NOT NULL
	,graphYear VARCHAR(50) NOT NULL
	,currentYearDataCoffee FLOAT(53)
	,inactiveYearDataCoffee FLOAT(53)
	,yearlyFarms FLOAT(53)
	,currentYearDataLand FLOAT(53)
	,inactiveYearDataLand FLOAT(53)
	,addedThisYear FLOAT(53)
	,PRIMARY KEY (
		lineOfBusiness
		,country
		,cluster
		,graphYear
		)
	);

--137
CREATE TABLE dwh.MT_DashboardTasq (
	lineOfBusiness VARCHAR(50)
	,country VARCHAR(50)
	,cluster VARCHAR(50)
	,criteriaId VARCHAR(50)
	,classification2 VARCHAR(50)
	,classification1 VARCHAR(50)
	,class1NonCompliance INT
	,class1TotalFarms INT
	,class2NonCompliance INT
	,class2TotalFarms INT
	,criteriaClass2NonCompliance INT
	,criteriaClass2TotalFarms INT
	,compliance INT
	,nonCompliance INT
	,reportFor VARCHAR(50)
	);

--138
CREATE TABLE dwh.MT_UOMConversion (
	ALT_UOM NVARCHAR(50) NOT NULL
	,BASE_UOM NVARCHAR(50) NOT NULL
	,CONV_FACT FLOAT(53)
	,PRIMARY KEY (
		ALT_UOM
		,BASE_UOM
		)
	);

--139
CREATE TABLE dwh.MT_LassoEntities (
	entityId VARCHAR(50)
	,type VARCHAR(50)
	,createdBy VARCHAR(50)
	,createdOn DATETIME2(0)
	);

--140
CREATE TABLE dwh.MT_FarmSummary (
	entityId VARCHAR(50) NOT NULL
	,status4C NVARCHAR(50)
	,coreAssessmentStatus NVARCHAR(50)
	,license4C NVARCHAR(50)
	,certifications NVARCHAR(1000)
	,primaryContactGender NVARCHAR(50)
	,primaryContactAge INT
	,lastSaleDate DATETIME2(0)
	,coffeeSoldThisYear FLOAT(53)
	,totalArea FLOAT(53)
	,arabicaProduction FLOAT(53)
	,robustaProduction FLOAT(53)
	,bourbonProduction FLOAT(53)
	,totalProduction FLOAT(53)
	,primaryAgronomistId VARCHAR(50)
	,noOfMovements INT
	,noOfMovementsCurrentYr INT
	,numReceivedPlantletsCurrYr INT
	,relationWithEntity NVARCHAR(50)
	,receivedPlantletFlag TINYINT
	,receivedPlantletFlagCurrentYr TINYINT
	,assessedCurrentYear TINYINT
	,isCertified TINYINT
	,totalYield FLOAT(53)
	,totalYieldUOM NVARCHAR(50)
	,numEvents INT
	,numVisits INT
	,numInteractions INT
	,numReceivedPlantlet INT
	,NumAssessmentCurrentYr INT
	,totalPlotArea FLOAT(53)
	,totalNoOfUnacceptableAns INT
	,TotalNoofCoreNC INT
	,coffeeArea FLOAT(53)
	,latest4CGroupId VARCHAR(50)
	,entityPoint VARBINARY(max)
	,entityGeometry VARBINARY(max)
	,licenseNumber NVARCHAR(50)
	,PRIMARY KEY (entityId)
	);

--141
CREATE TABLE dwh.MT_DashboardTasqYearly (
	lineOfBusiness VARCHAR(50)
	,country VARCHAR(50)
	,cluster VARCHAR(50)
	,classification1 VARCHAR(50)
	,complianceYear VARCHAR(50)
	,compliance INT
	,nonCompliance INT
	);

--142
CREATE TABLE dwh.OT_Allocation (
	deliveryNumber VARCHAR(50) NOT NULL
	,batchNumber NVARCHAR(255) NOT NULL
	,allocationId VARCHAR(50)
	,deliveryId VARCHAR(50)
	,batchDate DATETIME2(7)
	,quantityProcessed DECIMAL(15, 5)
	,dilutionRate DECIMAL(15, 5)
	,quantityAllocated DECIMAL(15, 5)
	,nnBatchNumber NVARCHAR(255)
	,containerCoffeeWeight DECIMAL(15, 5)
	,shippingDate DATETIME2(7)
	,containerICONumber NVARCHAR(255)
	,contactNumber NVARCHAR(255)
	,paymentDate DATETIME2(7)
	,exchangeRateVsUSD DECIMAL(15, 10)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,dateOfEmbarkment DATETIME2(7)
	,lineOfBusiness NVARCHAR(50)
	,PRIMARY KEY (
		deliveryNumber
		,batchNumber
		)
	);

--143
CREATE TABLE dwh.OT_Delivery (
	deliveryNumber VARCHAR(50) NOT NULL
	,deliveryId VARCHAR(50)
	,deliveryDate DATETIME2(7)
	,entityId VARCHAR(50)
	,location NVARCHAR(255)
	,purchasingPoint NVARCHAR(255)
	,purchaseCertified NVARCHAR(255)
	,harvestPeriod NVARCHAR(9)
	,coffeeSpecie NVARCHAR(255)
	,coffeeState NVARCHAR(255)
	,physicalQuality NVARCHAR(255)
	,cupQuality NVARCHAR(255)
	,deliveredQuantity DECIMAL(15, 5)
	,deliveredUnit NVARCHAR(50)
	,purchaseDate DATETIME2(7)
	,purchaseCurrency NVARCHAR(50)
	,purchaseExchangeRateVsUSD DECIMAL(15, 10)
	,purchaseBasePrice DECIMAL(15, 5)
	,purchaseNNTotal DECIMAL(15, 5)
	,purchaseAAAPremium DECIMAL(15, 5)
	,purchaseBENPremium DECIMAL(15, 5)
	,premiumCurrency NVARCHAR(50)
	,purchaseExchangePremiumRateVsUSD DECIMAL(15, 10)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,commodityType NVARCHAR(50) DEFAULT 'COFFEE'
	,pointOfPurchaseCode NVARCHAR(255)
	,invoiceNumber NVARCHAR(255)
	,lineOfBusiness NVARCHAR(50)
	,licenceNumber VARCHAR(50)
	,deliveryType NVARCHAR(50)
	,status NVARCHAR(50)
	,buyingStationEntityId VARCHAR(50)
	,PRIMARY KEY (deliveryNumber)
	);

--144
CREATE TABLE dwh.OT_Financial (
	accountId VARCHAR(50) NOT NULL
	,geoNodeId VARCHAR(50)
	,organisationId VARCHAR(50)
	,year INT
	,category NVARCHAR(255)
	,subcategory NVARCHAR(255)
	,description NVARCHAR(1000)
	,personnelName NVARCHAR(255)
	,startDate DATE
	,quantity DECIMAL(15, 5)
	,endDate DATE
	,annualNNBudget DECIMAL(15, 5)
	,annualCABudget DECIMAL(15, 5)
	,p1NNExecution DECIMAL(15, 5)
	,p1CAExecution DECIMAL(15, 5)
	,p2NNExecution DECIMAL(15, 5)
	,p2CAExecution DECIMAL(15, 5)
	,p3NNExecution DECIMAL(15, 5)
	,p3CAExecution DECIMAL(15, 5)
	,Comment NVARCHAR(1000)
	,lineOfBusiness NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (accountId)
	);

--145
CREATE TABLE dwh.OT_NNTracking (
	nnBatchNumber VARCHAR(50) NOT NULL
	,nnTrackingId VARCHAR(50)
	,supplier NVARCHAR(255)
	,nntContactNumber NVARCHAR(255)
	,nntPONumber NVARCHAR(255)
	,nntContractedContainerWeight DECIMAL(15, 5)
	,nntActualContainerWeight DECIMAL(15, 5)
	,nnAADifferential DECIMAL(15, 5)
	,nntAAAPremium DECIMAL(15, 5)
	,nntRAPremium DECIMAL(15, 5)
	,nntFLOPremium DECIMAL(15, 5)
	,nntFTPremium DECIMAL(15, 5)
	,nnFixationDate DATETIME2(7)
	,nnFixationLevel NVARCHAR(255)
	,nntShipmentDate DATETIME2(7)
	,nntArivalDateEurope DATETIME2(7)
	,nntWarehouse NVARCHAR(255)
	,nntReleaseStatus NVARCHAR(255)
	,nntReleaseDate DATETIME2(7)
	,nntRejectionReason NVARCHAR(255)
	,nntDateOfPayment DATETIME2(7)
	,nntAmountUSD DECIMAL(15, 5)
	,nntExchangeRate DECIMAL(15, 10)
	,lineOfBusiness NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,nntRecipient NVARCHAR(50)
	,nntPackagingType NVARCHAR(50)
	,nntRAPremiumCurrency NVARCHAR(50)
	,nntAAAPremiumCurrency NVARCHAR(50)
	,organicPremium DECIMAL(15, 5)
	,PRIMARY KEY (nnBatchNumber)
	);

--146
CREATE TABLE dwh.OT_OmpKPI (
	kpiId VARCHAR(50) NOT NULL
	,status NVARCHAR(50)
	,lineOfBusiness NVARCHAR(50)
	,kpiFamilyId VARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (kpiId)
	);

--147
CREATE TABLE dwh.OT_OmpKPIDefinition (
	kpiDefinitionId VARCHAR(50) NOT NULL
	,status NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (kpiDefinitionId)
	);

--148
CREATE TABLE dwh.OT_OmpKPIDefinition_Txt (
	kpiDefinitionId VARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,title NVARCHAR(255)
	,PRIMARY KEY (
		kpiDefinitionId
		,language
		)
	);

--149
CREATE TABLE dwh.OT_OmpKPIFamily (
	kpiFamilyId VARCHAR(50) NOT NULL
	,status NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (kpiFamilyId)
	);

--150
CREATE TABLE dwh.OT_OmpKPIFamily_Txt (
	kpiFamilyId VARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,title NVARCHAR(255)
	,PRIMARY KEY (
		kpiFamilyId
		,language
		)
	);

--151
CREATE TABLE dwh.OT_OmpKPIScore (
	kpiScoreId VARCHAR(50) NOT NULL
	,kpiScoreLow FLOAT(53)
	,kpiScoreHigh FLOAT(53)
	,kpiId VARCHAR(50)
	,kpiMeasurementId VARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,kpiScore INT
	,PRIMARY KEY (kpiScoreId)
	);

--152
CREATE TABLE dwh.OT_OmpKPIScore_Txt (
	kpiScoreId VARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,title NVARCHAR(255)
	,PRIMARY KEY (
		kpiScoreId
		,language
		)
	);

--153
CREATE TABLE dwh.OT_OmpKPIToMeasurement (
	kpiMeasurementId VARCHAR(50) NOT NULL
	,kpiId VARCHAR(50) NOT NULL
	,definitionSortOrder INT
	,measurementSortOrder INT
	,kpiDefinitionId VARCHAR(50)
	,kpiFamilySortOrder INT
	,kpiSortOrder INT
	,PRIMARY KEY (
		kpiMeasurementId
		,kpiId
		)
	);

--154
CREATE TABLE dwh.OT_OmpKPI_Txt (
	kpiId VARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,title NVARCHAR(255)
	,businessNeed NVARCHAR(1000)
	,PRIMARY KEY (
		kpiId
		,language
		)
	);

--155
CREATE TABLE dwh.OT_OmpMeasurement (
	kpiMeasurementId VARCHAR(50) NOT NULL
	,unitType NVARCHAR(50)
	,status NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,measurementCaptureType NVARCHAR(50)
	,measurementType NVARCHAR(50)
	,frequency NVARCHAR(50)
	,PRIMARY KEY (kpiMeasurementId)
	);

--156
CREATE TABLE dwh.OT_OmpMeasurement_Txt (
	kpiMeasurementId VARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,title NVARCHAR(255)
	,PRIMARY KEY (
		kpiMeasurementId
		,language
		)
	);

--157
CREATE TABLE dwh.OT_OmpPlan (
	planId VARCHAR(50) NOT NULL
	,geoNodeId VARCHAR(50)
	,title NVARCHAR(255)
	,year INT
	,status NVARCHAR(50)
	,validationSignOffByCtyMgr VARCHAR(50)
	,validationSignOffByCluMgr VARCHAR(50)
	,validateCommentCtyMgr NVARCHAR(1000)
	,validateCommentCluMgr NVARCHAR(1000)
	,finalReviewComment NVARCHAR(3000)
	,validationSeq INT
	,commentDeleted TINYINT
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,agronomistId VARCHAR(50)
	,PRIMARY KEY (planId)
	);

--158
CREATE TABLE dwh.OT_OmpPlanReview (
	planId VARCHAR(50) NOT NULL
	,planToPeriodId VARCHAR(50) NOT NULL
	,kpiId VARCHAR(50) NOT NULL
	,kpiMeasurementId VARCHAR(50) NOT NULL
	,reviewDate DATETIME2(0)
	,status NVARCHAR(50)
	,reviewSignOffCtyMgr VARCHAR(50)
	,reviewSignOffCluMgr VARCHAR(50)
	,reviewCommentCtyMgr NVARCHAR(1000)
	,reviewCommentCluMgr NVARCHAR(1000)
	,obtained DECIMAL(15, 5)
	,measurementScore FLOAT(53)
	,target DECIMAL(15, 5)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,reviewSeq INT
	,commentDeleted TINYINT
	,aggregatedObtained DECIMAL(15, 5)
	,PRIMARY KEY (
		planId
		,planToPeriodId
		,kpiId
		,kpiMeasurementId
		)
	);

--159
CREATE TABLE dwh.OT_OmpPlanReview_History (
	ompPlanReviewAuditId VARCHAR(50) NOT NULL
	,auditDate DATETIME2(7)
	,action NVARCHAR(50)
	,auditChangedBy NVARCHAR(50)
	,planId VARCHAR(50)
	,planToPeriodId VARCHAR(50)
	,kpiId VARCHAR(50)
	,kpiMeasurementId VARCHAR(50)
	,reviewDate DATETIME2(0)
	,status NVARCHAR(50)
	,reviewSignOffCtyMgr VARCHAR(50)
	,reviewSignOffCluMgr VARCHAR(50)
	,reviewCommentCtyMgr NVARCHAR(1000)
	,reviewCommentCluMgr NVARCHAR(1000)
	,obtained DECIMAL(15, 5)
	,measurementScore FLOAT(53)
	,target DECIMAL(15, 5)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,reviewSeq INT
	,isDeleted TINYINT
	,commentDeleted TINYINT
	,deletionDateTime DATETIME2(7)
	,aggregatedObtained DECIMAL(15, 5)
	,PRIMARY KEY (ompPlanReviewAuditId)
	);

--160
CREATE TABLE dwh.OT_OmpPlanTarget (
	planId VARCHAR(50) NOT NULL
	,kpiId VARCHAR(50) NOT NULL
	,kpiMeasurementId VARCHAR(50) NOT NULL
	,status NVARCHAR(50)
	,target DECIMAL(15, 5)
	,validateSignOffCtyMgr VARCHAR(50)
	,validateSignOffCluMgr VARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,validationSeq INT
	,PRIMARY KEY (
		planId
		,kpiId
		,kpiMeasurementId
		)
	);

--161
CREATE TABLE dwh.OT_OmpPlanTarget_History (
	auditDate DATETIME2(7) NOT NULL
	,action NVARCHAR(50)
	,auditChangedBy NVARCHAR(50)
	,planId VARCHAR(50) NOT NULL
	,kpiId VARCHAR(50) NOT NULL
	,kpiMeasurementId VARCHAR(50) NOT NULL
	,status NVARCHAR(50)
	,target DECIMAL(15, 5)
	,validateSignOffCtyMgr VARCHAR(50)
	,validateSignOffCluMgr VARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,validationSeq INT
	,PRIMARY KEY (
		auditDate
		,planId
		,kpiId
		,kpiMeasurementId
		)
	);

--162
CREATE TABLE dwh.OT_OmpPlanToKPI (
	planId VARCHAR(50) NOT NULL
	,kpiId VARCHAR(50) NOT NULL
	,kpiScore DECIMAL(15, 5)
	,PRIMARY KEY (
		planId
		,kpiId
		)
	);

--163
CREATE TABLE dwh.OT_OmpPlanToPeriod (
	planToPeriodId VARCHAR(50) NOT NULL
	,planId VARCHAR(50) NOT NULL
	,planEndDate DATE
	,isYearEndPeriod TINYINT
	,status NVARCHAR(50)
	,reviewSignOffByCtyMgr VARCHAR(50)
	,reviewSignOffByCluMgr VARCHAR(50)
	,reviewCommentCtyMgr NVARCHAR(1000)
	,reviewCommentCluMgr NVARCHAR(1000)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,validationSeq INT
	,reviewSeq INT
	,commentDeleted TINYINT
	,PRIMARY KEY (
		planToPeriodId
		,planId
		)
	);

--164
CREATE TABLE dwh.OT_OmpPlanToPeriod_History (
	ompPlanToPeriodAuditId VARCHAR(50) NOT NULL
	,auditDate DATETIME2(7)
	,action NVARCHAR(50)
	,auditChangedBy NVARCHAR(50)
	,planToPeriodId VARCHAR(50)
	,planId VARCHAR(50)
	,planEndDate DATE
	,isYearEndPeriod TINYINT
	,status NVARCHAR(50)
	,reviewSignOffByCtyMgr VARCHAR(50)
	,reviewSignOffByCluMgr VARCHAR(50)
	,reviewCommentCtyMgr NVARCHAR(1000)
	,reviewCommentCluMgr NVARCHAR(1000)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,isDeleted TINYINT
	,validationSeq INT
	,reviewSeq INT
	,commentDeleted TINYINT
	,deletionDateTime DATETIME2(7)
	,PRIMARY KEY (ompPlanToPeriodAuditId)
	);

--165
CREATE TABLE dwh.OT_OmpPlan_History (
	ompPlanAuditId VARCHAR(50) NOT NULL
	,auditDate DATETIME2(7)
	,action NVARCHAR(50)
	,auditChangedBy NVARCHAR(50)
	,planId VARCHAR(50)
	,geoNodeId VARCHAR(50)
	,title NVARCHAR(255)
	,year INT
	,status NVARCHAR(50)
	,validationSignOffByCtyMgr VARCHAR(50)
	,validationSignOffByCluMgr VARCHAR(50)
	,validateCommentCtyMgr NVARCHAR(1000)
	,validateCommentCluMgr NVARCHAR(1000)
	,finalReviewComment NVARCHAR(3000)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,isDeleted TINYINT
	,deletionDateTime DATETIME2(7)
	,validationSeq INT
	,commentDeleted TINYINT
	,agronomistId VARCHAR(50)
	,PRIMARY KEY (ompPlanAuditId)
	);

--166
CREATE TABLE dwh.PT_Movement (
	movementId VARCHAR(50) NOT NULL
	,type NVARCHAR(50)
	,status NVARCHAR(50)
	,varietyId VARCHAR(50)
	,propagationMethod NVARCHAR(50)
	,shipmentIdentifier NVARCHAR(255)
	,startEntityId VARCHAR(50) NOT NULL
	,endEntityId VARCHAR(50) NOT NULL
	,senderId VARCHAR(50)
	,sentOn DATETIME2(0)
	,sentQty INT
	,receiverId VARCHAR(50)
	,receivedOn DATETIME2(0)
	,receivedQty INT
	,[price.amount] FLOAT(53)
	,[price.currencyCode] NVARCHAR(50)
	,[costOfProduction.amount] FLOAT(53)
	,[costOfProduction.currencyCode] NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,lossReason NVARCHAR(50)
	,distributionPurpose NVARCHAR(50)
	,PRIMARY KEY (movementId)
	);

--167
CREATE TABLE dwh.PT_Movement_History (
	auditDate DATETIME2(7) NOT NULL
	,auditChangedBy NVARCHAR(50)
	,action NVARCHAR(50)
	,movementId VARCHAR(50) NOT NULL
	,type NVARCHAR(50)
	,status NVARCHAR(50)
	,varietyId VARCHAR(50)
	,propagationMethod NVARCHAR(50)
	,shipmentIdentifier NVARCHAR(255)
	,startEntityId VARCHAR(50) NOT NULL
	,endEntityId VARCHAR(50) NOT NULL
	,senderId VARCHAR(50)
	,sentOn DATETIME2(0)
	,sentQty INT
	,receiverId VARCHAR(50)
	,receivedOn DATETIME2(0)
	,receivedQty INT
	,[price.amount] FLOAT(53)
	,[price.currencyCode] NVARCHAR(50)
	,[costOfProduction.amount] FLOAT(53)
	,[costOfProduction.currencyCode] NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,lossReason NVARCHAR(50)
	,distributionPurpose NVARCHAR(50)
	,PRIMARY KEY (
		auditDate
		,movementId
		)
	);

--168
CREATE TABLE dwh.PT_NurseryStock (
	entityId VARCHAR(50) NOT NULL
	,varietyId VARCHAR(50) NOT NULL
	,originGenericMaterial NVARCHAR(50)
	,capacity INT
	,status NVARCHAR(50)
	,[costOfProduction.amount] FLOAT(53)
	,[costOfProduction.currencyCode] NVARCHAR(50)
	,[price.amount] FLOAT(53)
	,[price.currencyCode] NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (
		entityId
		,varietyId
		)
	);

--169
CREATE TABLE dwh.PT_NurseryStock_History (
	auditDate DATETIME2(7) NOT NULL
	,auditChangedBy NVARCHAR(50)
	,action NVARCHAR(50)
	,entityId VARCHAR(50) NOT NULL
	,varietyId VARCHAR(50) NOT NULL
	,originGenericMaterial NVARCHAR(50)
	,capacity INT
	,status NVARCHAR(50)
	,[costOfProduction.amount] FLOAT(53)
	,[costOfProduction.currencyCode] NVARCHAR(50)
	,[price.amount] FLOAT(53)
	,[price.currencyCode] NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (
		auditDate
		,entityId
		,varietyId
		)
	);

--170
CREATE TABLE dwh.PT_NurseryToPropMethod (
	entityId VARCHAR(50) NOT NULL
	,varietyId VARCHAR(50) NOT NULL
	,propagationMethod NVARCHAR(50) NOT NULL
	,PRIMARY KEY (
		entityId
		,varietyId
		,propagationMethod
		)
	);

--171
CREATE TABLE dwh.PT_SiteTrial (
	siteTrialId VARCHAR(50) NOT NULL
	,entityId VARCHAR(50) NOT NULL
	,status NVARCHAR(50)
	,parentTrialId VARCHAR(50)
	,startDate DATETIME2(0)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (siteTrialId)
	);

--172
CREATE TABLE dwh.PT_Trial (
	trialId VARCHAR(50) NOT NULL
	,type NVARCHAR(50)
	,name NVARCHAR(255)
	,description NVARCHAR(max)
	,status NVARCHAR(50)
	,geoNodeId VARCHAR(50)
	,startDate DATETIME2(0)
	,organisationId VARCHAR(50) NOT NULL
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (trialId)
	);

--173
CREATE TABLE dwh.PT_Variety (
	varietyId VARCHAR(50) NOT NULL
	,name NVARCHAR(255)
	,referenceNumber NVARCHAR(50)
	,genericFlag TINYINT
	,genericVarietyId VARCHAR(50)
	,status NVARCHAR(50)
	,species NVARCHAR(50)
	,origin NVARCHAR(50)
	,countryOfOrigin VARCHAR(50)
	,geneticStatus NVARCHAR(50)
	,arabicaShape NVARCHAR(50)
	,molecularSignature TINYINT
	,organisationId VARCHAR(50) NOT NULL
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,parents NVARCHAR(255)
	,propMethod NVARCHAR(50)
	,PRIMARY KEY (varietyId)
	);

--174
CREATE TABLE dwh.PT_VarietyCountryStatus (
	varietyId VARCHAR(50) NOT NULL
	,geoNodeId VARCHAR(50) NOT NULL
	,validationStatus NVARCHAR(50)
	,localProcureCompliance NVARCHAR(50)
	,exportProcureCompliance NVARCHAR(50)
	,distributionAllowed NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,status NVARCHAR(50)
	,localName NVARCHAR(255)
	,PRIMARY KEY (
		varietyId
		,geoNodeId
		)
	);

--175
CREATE TABLE dwh.PT_VarietyCountryToLOB (
	varietyId VARCHAR(50) NOT NULL
	,geoNodeId VARCHAR(50) NOT NULL
	,lineOfBusiness NVARCHAR(50) NOT NULL
	,PRIMARY KEY (
		varietyId
		,geoNodeId
		,lineOfBusiness
		)
	);

--176
CREATE TABLE dwh.PT_VarietyResistance (
	varietyId VARCHAR(50) NOT NULL
	,resistanceType NVARCHAR(50) NOT NULL
	,afflictionType NVARCHAR(50) NOT NULL
	,resistanceLevel NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (
		varietyId
		,resistanceType
		,afflictionType
		)
	);

--177
CREATE TABLE dwh.PT_VarietyToEntity (
	varietyId VARCHAR(50) NOT NULL
	,entityId VARCHAR(50) NOT NULL
	,percentage FLOAT(53)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (
		varietyId
		,entityId
		)
	);

--178
CREATE TABLE dwh.PT_VarietyToEntity_History (
	auditDate DATETIME2(7) NOT NULL
	,auditChangedBy NVARCHAR(50)
	,action NVARCHAR(50)
	,varietyId VARCHAR(50) NOT NULL
	,entityId VARCHAR(50) NOT NULL
	,percentage FLOAT(53)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (
		auditDate
		,varietyId
		,entityId
		)
	);

--179
CREATE TABLE dwh.PT_VarietyToParent (
	childVarietyId VARCHAR(50) NOT NULL
	,parentVarietyId VARCHAR(50) NOT NULL
	,PRIMARY KEY (
		childVarietyId
		,parentVarietyId
		)
	);

--180
CREATE TABLE dwh.PT_VarietyToPlot (
	varietyId VARCHAR(50) NOT NULL
	,plotId VARCHAR(50) NOT NULL
	,PRIMARY KEY (
		varietyId
		,plotId
		)
	);

--181
CREATE TABLE dwh.PT_VarietyToPropMethod (
	varietyId VARCHAR(50) NOT NULL
	,propMethod NVARCHAR(50) NOT NULL
	,PRIMARY KEY (
		varietyId
		,propMethod
		)
	);

--182
CREATE TABLE dwh.PT_VarietyTrial (
	varietyTrialId VARCHAR(50) NOT NULL
	,status NVARCHAR(50)
	,parentSiteTrialId VARCHAR(50) NOT NULL
	,varietyId VARCHAR(50) NOT NULL
	,referenceIndicator TINYINT
	,propagationMethod NVARCHAR(50)
	,[auditInfo.createdBy] VARCHAR(50)
	,[auditInfo.createdOn] DATETIME2(7)
	,[auditInfo.modifiedBy] VARCHAR(50)
	,[auditInfo.modifiedOn] DATETIME2(7)
	,[auditInfo.requestedBy] VARCHAR(50)
	,[auditInfo.modifiedReasonCode] NVARCHAR(50)
	,[auditInfo.channel] NVARCHAR(50)
	,PRIMARY KEY (varietyTrialId)
	);

--183
CREATE TABLE dwh.ET_EntityToEmployee_History(
	auditDate DATETIME2(7) NOT NULL,
	auditChangedBy NVARCHAR(50),
	action NVARCHAR(50),
	entityId VARCHAR(50) NOT NULL,
	employeeId VARCHAR(50) NOT NULL,
	relationWithEntity NVARCHAR(50),
	PRIMARY KEY (
		auditDate,
		entityId,
		employeeId
	)
);