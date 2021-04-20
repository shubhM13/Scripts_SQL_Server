select count(*) from [dwh].[MT_FarmSummary]
select count(*) from [dwh].[ET_Entity]
select TOP(10)* from [dwh].[CT_Organisation]
select TOP(10)* from [dwh].[ET_Group]
select TOP(10)* from [dwh].[ET_Entity]
select TOP(10)* from [stg].[ET_GroupToEntity]
select TOP(10)* from [stg].[ET_GroupToOrg]
select distinct(isPartOfAgripreneurship) from [dwh].[ET_Entity]
select distinct nurseryOnSite from [dwh].[ET_Entity]
select distinct millOnSite from [dwh].[ET_Entity]
--1) altZ bad data
select distinct altZ from [STG].[ET_Entity] where ISNUMERIC(altZ) <> 1
select * from [STG].[ET_Entity] where altZ = '2017-07-14 07:00:00.0000000'
select * from [dwh].[ET_Entity] where altZ IS NULL 

--Fix 1
update [dwh].[ET_Entity]
set altZ = NULL
where altZ = '2017-07-14 07:00:00.0000000'

--2) nurseryOnSite bad data
select distinct nurseryOnSite from [stg].[ET_Entity] where ISNUMERIC(nurseryOnSite) <> 1
select * from [stg].[ET_Entity] where nurseryOnSite = '2020-04-05 00:00:00.0000000'

--Fix 2
update [dwh].[ET_Entity]
set nurseryOnSite = NULL
where nurseryOnSite = '2020-04-05 00:00:00.0000000'

--3) foundationYear bad data
select distinct foundationYear from [dwh].[ET_Entity] where ISDATE(foundationYear) <> 1
select * from [stg].[ET_Entity] where foundationYear = 'P001098'

--Fix 3
update [dwh].[ET_Entity]
set foundationYear = NULL
where foundationYear = 'P001098'

--4) AAAEntryYear bad data
select distinct AAAEntryYear from [dwh].[ET_Entity] where ISDATE(AAAEntryYear) <> 1
select * from [stg].[ET_Entity] where AAAEntryYear = '2020-04-03 11:15:22.0000000'

--Fix 4
select YEAR('2020-04-03 11:15:22.0000000')

update [dwh].[ET_Entity]
set AAAEntryYear = YEAR('2020-04-03 11:15:22.0000000')
where AAAEntryYear = '2020-04-03 11:15:22.0000000'


--5) relationshipDate bad data
select distinct CONVERT(Datetime2, relationshipDate, 120) from [dwh].[ET_Entity]
select distinct CAST(relationshipDate AS datetime2(0)) from [dwh].[ET_Entity]
select distinct relationshipDate from [dwh].[ET_Entity] where ISDATE(SUBSTRING(relationshipDate, 0, 11)) <> 1
select * from [stg].[ET_Entity] where relationshipDate = 'P001098'

select * from [dwh].[AT_Observation] where entityId = 'D295875E97180CD7E10000000A4E71D5';
select * from [dwh].[IT_Interaction] where entityId IN ('D295875E97180CD7E10000000A4E71D5', 'E095875E97180CD7E10000000A4E71D5');
select * from [dwh].[PT_Movement] where
startEntityId IN ('D295875E97180CD7E10000000A4E71D5', 'E095875E97180CD7E10000000A4E71D5')
OR endEntityId IN ('D295875E97180CD7E10000000A4E71D5', 'E095875E97180CD7E10000000A4E71D5');

select name from [stg].[ET_Entity] where name LIKE '%\%'
