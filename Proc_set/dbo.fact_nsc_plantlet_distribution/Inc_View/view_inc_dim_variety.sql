/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_dim_variety]    Script Date: 22/07/2021 10:42:36 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 20th May, 2021
 PURPOSE    : Variety Nescafe Dataset
 *******************************************/
--drop view [dm].[view_inc_dim_variety]
CREATE VIEW [dm].[view_inc_dim_variety]
AS
(
		SELECT DISTINCT (A.varietyId)
			,A.name
			,A.referenceNumber
			,A.genericFlag
			,A.STATUS
			,A.species
			,A.origin
			,A.geneticStatus
			,A.arabicaShape
			,A.molecularSignature
			,A.organisationId
			,A.parents
			,A.propMethod
			,A.countryOfOrigin
		FROM [dwh].[PT_Variety] AS A
			--Removing this to match the hana numbers
			--INNER JOIN [dwh].[CT_Organisation] AS B WITH (NOLOCK)
			--	ON A.organisationId = B.organisationId
			--where B.lineOfBusiness IN ( 'NESCAFE' ,'GLOBAL' )
		AND A.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'PT' and sqltablename = 'Variety')
		);
GO