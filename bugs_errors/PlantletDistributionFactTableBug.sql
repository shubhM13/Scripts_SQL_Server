select A_mId, B_mId, A_endE, B_endE, COUNT(*)
from (
		(select A.movementId AS A_mId, B.entityId as A_endE from 
		[dwh].[PT_Movement] AS A
		LEFT OUTER JOIN 
		[dwh].[ET_Entity] AS B
		ON A.startEntityId = B.entityId) AS C
		INNER JOIN
		(select D.movementId AS B_mId, G.entityId AS B_endE, G.personId AS B_personE from 
		[dwh].[PT_Movement] AS D
		LEFT OUTER JOIN 
		    (select E.entityId, F.personId from 
			[dwh].[ET_Entity] AS E
			LEFT OUTER JOIN 
			[dwh].[ET_Person] AS F
			ON E.entityId = F.entityId
			and F.primaryIndicator = 1) AS G
		ON D.endEntityId = G.entityId) AS H
		ON C.A_mId = H.B_mId)
GROUP BY A_mId, B_mId, A_endE, B_endE
HAVING COUNT(*) > 1;