SELECT D.* FROM
	 (
        select C.triggerdate
            ,C.adfname
            ,C.pipelinename
            ,C.runid
            ,C.triggername
            ,CASE WHEN C.error = 0
            THEN 1
            ELSE 0
            END AS STATUS
            ,C.activitycount 
            ,C.totalrowsread 
            ,C.totalrowscopied
            ,C.totalcopyduration  
            ,RANK() OVER (PARTITION BY pipelinename ORDER BY triggerdate DESC) AS rnk
        from (
            select CAST(triggertime as date) triggerdate
                ,adfname
                ,pipelinename
                ,runid
                ,triggername
                ,SUM(errorFlag) AS error
                ,COUNT(distinct activityname) as activitycount
                ,SUM(rowsread) AS totalrowsread
                ,SUM(rowscopied) AS totalrowscopied
                ,SUM(copyduration) AS totalcopyduration
            from (
                SELECT A.*
                ,CASE WHEN A.errors = 'NA' 
                OR A.errors = 'System.Collections.Generic.List`1[System.Object]' 
                OR A.errors = 'No Error'
                THEN 0
                ELSE 1
                END AS errorFlag
                From audit.adf_pipeline_logs AS A
            ) AS B
            group by CAST(triggertime as date), pipelinename, runid, triggername, adfname
        ) AS C
     ) AS D
where D.rnk = 1
AND D.pipelinename IN ('PL_SAP_To_ADLS_To_STG_Delta_Load', 'PL_STG_To_DWH_Delta_Load', 'PL_Non_AUDIT_Tables_SAP_To_DWH');

select distinct errors from audit.adf_pipeline_logs;

select count(*) from dbo.WaterMark;

select C.triggerdate
     ,C.pipelinename
     ,C.runid
     ,C.triggername
     ,CASE WHEN C.error = 0
     THEN 'Success'
     ELSE 'Fail'
     END AS STATUS
     ,C.activitycount 
     ,C.totalrowsread 
     ,C.totalrowscopied
     ,C.totalcopyduration  
from (
    select CAST(triggertime as date) triggerdate
        ,pipelinename
        ,runid
        ,triggername
        ,SUM(errorFlag) AS error
        ,COUNT(distinct activityname) as activitycount
        ,SUM(rowsread) AS totalrowsread
        ,SUM(rowscopied) AS totalrowscopied
        ,SUM(copyduration) AS totalcopyduration
    from (
        SELECT A.*
        ,CASE WHEN A.errors = 'NA' 
        OR A.errors = 'System.Collections.Generic.List`1[System.Object]' 
        OR A.errors = 'No Error'
        THEN 0
        ELSE 1
        END AS errorFlag
        From audit.adf_pipeline_logs AS A
    ) AS B
    group by CAST(triggertime as date), pipelinename, runid, triggername
) AS C
order by C.triggerdate DESC,
CASE C.pipelinename
    WHEN 'PL_SAP_To_ADLS_To_STG_Delta_Load' THEN 1
    WHEN 'PL_STG_To_DWH_Delta_Load' THEN 2
    WHEN 'PL_Non_AUDIT_Tables_SAP_To_DWH' THEN 3
    ELSE 5
END,
CASE C.runid
    WHEN 'StoredProcedure' THEN 1
    ELSE 2
END;

select CAST(triggertime as date) triggerdate
       ,pipelinename
       ,runid
       ,triggername
       ,SUM(errorFlag) AS error
       ,COUNT(distinct activityname) as activitycount
       ,COUNT(distinct tablename) as tables
       ,SUM(rowsread) AS totalrowsread
       ,SUM(rowscopied) AS totalrowscopied
       ,SUM(copyduration) AS totalcopyduration
from (
    SELECT A.*
    ,CASE WHEN A.errors = 'NA' OR A.errors = 'System.Collections.Generic.List`1[System.Object]' OR A.errors = 'No Error'
    THEN 0
    ELSE 1
    END AS errorFlag
    From audit.adf_pipeline_logs AS A
) AS B
group by CAST(triggertime as date), pipelinename, runid, triggername
order by triggerdate DESC,
   CASE pipelinename
      WHEN 'PL_SAP_To_ADLS_To_STG_Delta_Load' THEN 1
      WHEN 'PL_STG_To_DWH_Delta_Load' THEN 2
      WHEN 'PL_Non_AUDIT_Tables_SAP_To_DWH' THEN 3
      ELSE 5
   END,
   CASE runid
      WHEN 'StoredProcedure' THEN 1
      ELSE 2
   END
