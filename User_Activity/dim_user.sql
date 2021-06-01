/*******************************************
 Author     : Shubham Mishra
 Created On : 29th April
 PURPOSE    : User Activity Historical Model
 *******************************************/
--drop view dm.view_dim_user;
CREATE VIEW dm.view_dim_user
AS
(
		SELECT  distinct A.userName
				,A.organisationId
				,B.name AS orgName
				,B.lineOfBusiness AS lineOfBusiness
				,A.employeeId
				,A.[personInfo.firstName] + ' ' + A.[personInfo.lastName] AS employeeName
				,A.status 
				,A.[contactInfo.email] AS employeeEmail
				,I.label AS gender
				,D.label AS businessRole
				,ISNULL(C.country_name, 'N/A') AS country
		FROM [dwh].[CT_Employee] AS A
		INNER JOIN [dwh].[CT_Organisation] AS B ON A.organisationId = B.organisationId
		AND A.userName NOT IN ('FARMS_TECH', 'P000008')
		AND A.userName IS NOT NULL
		LEFT JOIN [dm].[dim_geonode_flat] AS C ON A.[addressInfo.countryCode] = C.[countryCode]
		AND C.type = 'COUNTRY'
		LEFT JOIN [dm].[dim_list_option] AS D WITH (NOLOCK) ON A.businessRole = D.itemCode
			AND D.setId = 'BUSINESS_ROLE'
		LEFT JOIN [dm].[dim_list_option] AS I WITH (NOLOCK) ON A.[personInfo.gender] = I.itemCode
			AND I.setId = 'GENDER'
		);

drop table dm.dim_user;

SELECT *
INTO dm.dim_user
FROM dm.view_dim_user;

ALTER TABLE dm.dim_user ALTER COLUMN userName varchar(100) NOT NULL;
--ALTER TABLE dm.dim_user ADD CONSTRAINT dimUser_pk PRIMARY KEY (userName);

SELECT *
FROM dm.view_dim_user;


SELECT *
FROM dm.dim_user;


EXEC dm.usp_merge_dim_user;
