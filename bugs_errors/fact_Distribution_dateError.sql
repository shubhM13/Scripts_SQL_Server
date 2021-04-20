select sent_received_date from [dm].[fact_nsc_plantlet_distribution]
where sent_received_date NOT IN (
select dateKey from [dm].[dim_date])


select * from [dm].[fact_nsc_plantlet_distribution] where 
movementId = '686AF35F6D963A4CE10000000A793047'

select * from [dwh].[PT_Movement]
where movementId = '686AF35F6D963A4CE10000000A793047'

UPDATE [dm].[fact_nsc_plantlet_distribution]
SET sent_received_date = 20201124
where movementId = '686AF35F6D963A4CE10000000A793047'
AND interaction_type = 'RECEIVED'