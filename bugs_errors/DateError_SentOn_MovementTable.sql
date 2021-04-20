select * from dwh.PT_movement
where movementId = '686AF35F6D963A4CE10000000A793047';

Update dm.fact_nsc_plantlet_distribution 
SET sentOn = 20200519
where movementId = '686AF35F6D963A4CE10000000A793047';

select * from dm.fact_nsc_plantlet_distribution 
where movementId = '686AF35F6D963A4CE10000000A793047';