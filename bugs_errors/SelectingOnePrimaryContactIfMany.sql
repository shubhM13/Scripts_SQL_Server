SELECT * FROM 
 (  
 SELECT entityId
      , personId
      , RANK() OVER (PARTITION BY entityId ORDER BY [auditInfo.createdOn] desc) AS rnk 
   FROM [dwh].[ET_Person]
 ) AS A
 where A.rnk = 1;

