SET ANSI_NULLS ON
GO

 

SET QUOTED_IDENTIFIER ON
GO

 

/*******************************************
 Author     : Jeevitha Gajendran
 Created On : 29th April, 2021
 PURPOSE    : Dim Organisation Flat Nespresso Dataset
 *******************************************/
--drop view dm.view_dim_nsp_OrganisationFlat
CREATE VIEW [dm].[view_dim_nsp_OrganisationFlat]
AS
(
        SELECT organisationId AS organisationId
            ,name AS organisationName
        FROM [dwh].[CT_Organisation] AS OrganisationFlat
        Where OrganisationFlat.lineOfBusiness IN (
                'NESPRESSO'
                ,'GLOBAL'
                )
        );
GO

select *
into [dm].[dim_nsp_OrganisationFlat]
from [dm].[view_dim_nsp_OrganisationFlat];

ALTER TABLE  [dm].[dim_nsp_OrganisationFlat] ADD CONSTRAINT dimNspOrgFlat_pk PRIMARY KEY (organisationId);

select * from [dm].[dim_nsp_OrganisationFlat]