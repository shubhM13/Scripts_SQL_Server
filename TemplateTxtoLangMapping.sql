select COUNT(*) from 
dwh.AT_Criteria_Txt
where criteriaId IN (
	select criteriaId from(
		select criteriaId, count(language) AS Count
		from dwh.AT_criteria_Txt
		group by criteriaId) AS A
		where A.Count > 1)
AND language = 'E'

select COUNT(*) from dwh.AT_Criteria
