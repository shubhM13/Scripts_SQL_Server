SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/*******************************************
 Author     : Shubham Mishra
 Created On : 23rd March, 2021
 PURPOSE    : RLS 
 *******************************************/
--drop view [dm].[view_nsc_org_tree]
CREATE VIEW [dm].[view_nsc_org_tree]
AS
WITH OrgTree (indent, organisationId, name, parentId, Tree)
AS
(
   SELECT CAST('' AS varchar) as indent, organisationId, name, parentId , 0 AS Tree 
   FROM [dwh].[CT_Organisation]
   WHERE parentId IS NULL
   AND lineOfBusiness IN ('GLOBAL', 'NESCAFE')
   UNION ALL
   SELECT CAST(OrgTree.indent + '_._._. ' AS varchar), A.organisationId, A.name, A.parentId , OrgTree.Tree + 1
   FROM [dwh].[CT_Organisation] AS A
   JOIN OrgTree ON A.parentId = OrgTree.organisationId
   AND lineOfBusiness IN ('GLOBAL', 'NESCAFE')
)
SELECT indent + organisationId AS organisationIndent,  organisationId, name, parentId, Tree FROM OrgTree
GO

select * from [dm].[view_nsc_org_tree] order by Tree;
