drop table stg.CT_Employee;
CREATE TABLE stg.CT_Employee (
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

drop table stg.CT_ListOption;
CREATE TABLE stg.CT_ListOption (
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

drop table stg.CT_ListOption_Txt;
CREATE TABLE stg.CT_ListOption_Txt (
	setId VARCHAR(50) NOT NULL
	,itemCode NVARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,label NVARCHAR(max) NOT NULL
	,description NVARCHAR(max)
	,PRIMARY KEY (
		setId
		,itemCode
		,language
		)
	);

drop table stg.ET_Person;
CREATE TABLE stg.ET_Person (
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


drop table dwh.CT_Employee;
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

drop table dwh.CT_ListOption;
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

drop table dwh.CT_ListOption_Txt;
CREATE TABLE dwh.CT_ListOption_Txt (
	setId VARCHAR(50) NOT NULL
	,itemCode NVARCHAR(50) NOT NULL
	,language NVARCHAR(2) NOT NULL
	,label NVARCHAR(max) NOT NULL
	,description NVARCHAR(max)
	,PRIMARY KEY (
		setId
		,itemCode
		,language
		)
	);

drop table dwh.ET_Person;
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
	
drop table dm.dim_employee;
CREATE TABLE dm.dim_employee (
	employeeId VARCHAR(50) NOT NULL
	,externalSystemId VARCHAR(50)
	,organisationId VARCHAR(50) NOT NULL
	,businessRole NVARCHAR(50)
	,status NVARCHAR(50)
	,userName NVARCHAR(50)
	,[personInfo.firstName] NVARCHAR(255)
	,[personInfo.lastName] NVARCHAR(255)
	,[personInfo.gender] NVARCHAR(50)
	,[personInfo.maritalStatus] NVARCHAR(50)
	,[contactInfo.email] NVARCHAR(100)
	,[contactInfo.fixedPhone] NVARCHAR(50)
	,languageCode NVARCHAR(2)
	,managerId VARCHAR(50)
	,PRIMARY KEY (employeeId)
	);

drop table dm.dim_person;
CREATE TABLE dm.dim_person (
	personId VARCHAR(50) NOT NULL
	,externalSystemId VARCHAR(50)
	,externalSystemId2 VARCHAR(50)
	,status NVARCHAR(50)
	,[personInfo.firstName] NVARCHAR(255)
	,[personInfo.lastName] NVARCHAR(255)
	,[personInfo.gender] NVARCHAR(50)
	,[personInfo.maritalStatus] NVARCHAR(50)
	,[contactInfo.email] NVARCHAR(100)
	,[contactInfo.fixedPhone] NVARCHAR(50)
	,entityId VARCHAR(50) NOT NULL
	,primaryIndicator TINYINT
	,worksWithCoffee NVARCHAR(50)
	,relationToEntity NVARCHAR(50)
	,livesAt NVARCHAR(50)
	,deliversCoffee NVARCHAR(50)
	,PRIMARY KEY (personId)
	);