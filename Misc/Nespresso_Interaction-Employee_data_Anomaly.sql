select distinct C.interactionId AS [Interaction Id]
				, H.observationId AS [Interaction ObservationId]
				,G.[auditInfo.channel] AS [Interaction Channel]
				,G.[auditInfo.modifiedOn] AS [Interaction Modified Date]
				, C.interactionTypeTxt AS [Interaction Type]
				, C.interactionStatusTxt AS [Interaction Status]
				, H.status AS [Observation Status]
				, I.externalId AS [Observation Criteria Id]
				, J.title AS [Criteria Title]
				, J.shortDescription AS [Short Description]
				, B.employeeId AS [Inteaction employeeId]
				, B.[personInfo.firstname] +' ' +B.[personInfo.lastName] AS [Interaction Employee Name]
				, B.[status] AS [Interaction Employee Status]
				, A.organisationId AS [Interaction Employee OrgId]
				, A.name AS [Interaction Employee Org Name]
				, A.lineOfBusiness AS [Interaction Employee Org LoB] 
				, C.interactionOrganisationId AS [Interaction Organisation Id]
				, C.interactionOrgName AS [Interaction Org Name]
				, D.lineOfBusiness AS [Interaction Org LoB]
				, E.entityId AS [Interaction Entity Id]
				, E.name AS [Interaction Entity Name]
				, E.status AS [Entity Status]
				, E.geoNodeId AS [Interaction Entity GeoNode]
				 ,E.name AS [GeoNode name]
				, F.lineOfBusiness AS [Interaction Entity LoB]
from [dwh].[CT_Organisation] AS A
INNER JOIN [dwh].[CT_Employee] AS B on A.organisationId = B.organisationId
AND A.lineOfBusiness = 'NESCAFE'
INNER JOIN [dm].[fact_nsp_assessment_analysis] AS C ON C.interactionEmployeeId = B.employeeId
INNER JOIN [dwh].[CT_Organisation] AS D ON C.interactionOrganisationId = D.organisationId
INNER JOIN dwh.ET_Entity AS E ON C.entityId = E.entityId
INNER JOIN dwh.CT_GeoNode AS F ON E.geoNodeId = F.geoNodeId
INNER JOIN dwh.IT_Interaction AS G ON G.interactionId = C.interactionId
INNER JOIN dwh.AT_Observation AS H ON G.interactionId = H.interactionId
INNER JOIN dwh.AT_criteria AS I ON H.criteriaId = I.criteriaId
INNER JOIN dwh.AT_Criteria_Txt AS J ON J.criteriaId = I.criteriaId
AND J.language = 'E'
ORDER BY B.employeeId

select distinct language from dwh.AT_Criteria_Txt
