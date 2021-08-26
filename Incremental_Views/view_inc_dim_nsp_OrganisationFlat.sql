/*    ==Scripting Parameters==

    Source Database Engine Edition : Microsoft Azure SQL Database Edition
    Source Database Engine Type : Microsoft Azure SQL Database

    Target Database Engine Edition : Microsoft Azure SQL Database Edition
    Target Database Engine Type : Microsoft Azure SQL Database
*/
/****** Object:  View [dm].[view_inc_dim_nsp_OrganisationFlat]    Script Date: 22/07/2021 7:16:19 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 29th April, 2021
 PURPOSE    : Dim Organisation Flat Nespresso Dataset
 *******************************************/
--drop view dm.view_inc_dim_nsp_OrganisationFlat
CREATE VIEW [dm].[view_inc_dim_nsp_OrganisationFlat]
AS
(
		SELECT organisationId AS organisationId
			,name AS organisationName
		FROM [dwh].[CT_Organisation] AS OrganisationFlat
		WHERE OrganisationFlat.lineOfBusiness IN (
				'NESPRESSO'
				,'GLOBAL'
				)
		);
		AND OrganisationFlat.[auditInfo.modifiedOn] >= (select waterMarkVal from [AUDIT].[WaterMark] where schemaname = 'CT' and sqltablename = 'Organisation')
GO