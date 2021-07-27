--adoption
EXEC dm.usp_merge_dim_criteria;
EXEC dm.usp_merge_dim_nsc_entity_master;
EXEC dm.usp_merge_fact_nsc_adoption;

--agronomist
EXEC dm.usp_merge_dim_nsc_employee;
EXEC dm.usp_merge_dim_assessment;
EXEC dm.usp_merge_dim_fact_nsc_agronomist_performance;

--plantlet assessment
EXEC dm.usp_merge_dim_nsc_person;
EXEC dm.usp_merge_fact_nsc_plantlet_assessment;

--mobile sync
EXEC dm.usp_merge_fact_employee_mobile_sync_analysis;
