EXEC dm.usp_merge_dim_nsc_entity_master;
EXEC dm.usp_merge_dim_nsc_employee;
EXEC dm.usp_merge_dim_assessment;
EXEC dm.usp_merge_dim_fact_nsc_agronomist_performance;

EXEC dm.usp_merge_fact_employee_mobile_sync_analysis;
EXEC dm.usp_merge_fact_nsc_plantlet_distribution;

EXEC dm.GenerateFixedMergeSQL 'dm', 'fact_nsc_plantlet_distribution';