
select startEntityId from [dwh].[PT_Movement]
where startEntityId NOT IN
(select entityId from [dwh].[ET_Entity]);

select endEntityId from [dwh].[PT_Movement]
where endEntityId NOT IN
(select entityId from [dwh].[ET_Entity]);
