/*******************************************
 Name		: dm.view_event_to_employee_flat
 Author     : Shubham Mishra
 Created On : 4th May
 PURPOSE    : Entity General Analysis 
 *******************************************/
 --drop view dm.view_event_to_employee_flat;
CREATE VIEW dm.view_event_to_employee_flat
AS
(
		SELECT DISTINCT a.eventId
					    ,STUFF(
						 (SELECT DISTINCT '; ' + ISNULL(Q.[personInfo.firstName], '') + ' ' +  ISNULL(Q.[personInfo.lastName], '')
						  FROM [dwh].[IT_EventToEmployee] AS P
						  INNER JOIN [dwh].[CT_Employee] AS Q ON P.employeeId = Q.employeeId
						  WHERE P.eventId = a.eventId
						  FOR XML PATH (''))
						  , 1, 1, '')  AS eventEmployees
					    ,STUFF(
						 (SELECT DISTINCT '; ' + ISNULL(S.[contactInfo.email], '')
						  FROM [dwh].[IT_EventToEmployee] AS R
						  INNER JOIN [dwh].[CT_Employee] AS S ON R.employeeId = S.employeeId
						  WHERE R.eventId = a.eventId
						  FOR XML PATH (''))
						  , 1, 1, '')  AS employeeEmails
						,count(a.employeeId) AS employeeCount
		FROM [dwh].[IT_EventToEmployee] AS a
		GROUP BY a.eventId
	);