select tab.name as [table]
   from sys.tables tab
        inner join sys.partitions part
            on tab.object_id = part.object_id
where part.index_id IN (1, 0) -- 0 - table without PK, 1 table with PK
AND schema_name(schema_id) = 'stg'
group by tab.name
having sum(part.rows) <> 0
order by [table]