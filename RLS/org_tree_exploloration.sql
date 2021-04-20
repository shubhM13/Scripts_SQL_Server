[dwh].[CT_Organisation_Closure]
select count(*) from [dwh].[CT_Organisation];

WITH OrgTree (indent, organisationId, name, parentId, Tree)
AS
(
   SELECT CAST('' AS varchar) as indent, organisationId, name, parentId , 0 AS Tree 
   FROM [dwh].[CT_Organisation]
   WHERE parentId IS NULL
   AND lineOfBusiness IN ('GLOBAL', 'NESPRESSO')
   UNION ALL
   SELECT CAST(OrgTree.indent + '_._._. ' AS varchar), A.organisationId, A.name, A.parentId , OrgTree.Tree + 1
   FROM [dwh].[CT_Organisation] AS A
   JOIN OrgTree ON A.parentId = OrgTree.organisationId
   AND lineOfBusiness IN ('GLOBAL', 'NESPRESSO')
)
SELECT indent + organisationId AS organisationIndent, organisationId, name, parentId, Tree FROM OrgTree ORDER BY Tree

WITH OrgTree (indent, organisationId, name, parentId, Tree)
AS
(
   SELECT CAST('' AS varchar) as indent, organisationId, name, parentId , 0 AS Tree 
   FROM [dwh].[CT_Organisation]
   WHERE organisationId = 'RA_NESCAFE'
   UNION ALL
   SELECT CAST(OrgTree.indent + '_._._. ' AS varchar), A.organisationId, A.name, A.parentId , OrgTree.Tree + 1
   FROM [dwh].[CT_Organisation] AS A
   JOIN OrgTree ON A.parentId = OrgTree.organisationId
   AND lineOfBusiness IN ('GLOBAL', 'NESCAFE')
)
--select * from OrgTree ORDER BY Tree
SELECT indent + organisationId AS organisationId, parentId, name, Tree FROM OrgTree ORDER BY Tree