DROP PROCEDURE [dm].[GenerateMergeSQL] 
CREATE PROCEDURE [dm].[GenerateMergeSQL] 
@SrcSchemaName VARCHAR(100)
,@SrcTableName VARCHAR(100)
,@TgtSchemaName VARCHAR(100)
,@TgtTableName VARCHAR(100)
AS
BEGIN
	SET NOCOUNT ON

	DECLARE @sql VARCHAR(5000)
		,@SourceInsertColumns VARCHAR(5000)
		,@DestInsertColumns VARCHAR(5000)
		,@UpdateClause VARCHAR(5000)
	DECLARE @ColumnName VARCHAR(100)
		,@identityColName VARCHAR(100)
	DECLARE @IsIdentity INT
		,@IsComputed INT
		,@Data_Type VARCHAR(50)
	DECLARE @SourceDB AS VARCHAR(200)

	-- source/dest i.e. 'instance.catalog.owner.' - table names will be appended to this
	-- the destination is your current db context
	SET @SourceDB = ''
	SET @sql = ''
	SET @SourceInsertColumns = ''
	SET @DestInsertColumns = ''
	SET @UpdateClause = ''
	SET @ColumnName = ''
	SET @isIdentity = 0
	SET @IsComputed = 0
	SET @identityColName = ''
	SET @Data_Type = ''

	DECLARE @ColNames CURSOR SET @ColNames = CURSOR
	FOR
	SELECT A.column_name
		,CASE 
			WHEN C.COLUMN_NAME = A.COLUMN_NAME
			THEN 1
			ELSE 0 
			END AS IsIdentity
		,COLUMNPROPERTY(object_id(@SrcSchemaName+'.'+@SrcTableName), A.COLUMN_NAME, 'IsComputed') AS IsComputed
		,A.DATA_TYPE
	FROM information_schema.columns AS A
	INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS AS B
	ON A.TABLE_NAME = B.TABLE_NAME
	AND A.TABLE_SCHEMA = B.TABLE_SCHEMA
	INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS C
	ON B.TABLE_NAME = C.TABLE_NAME
	AND B.TABLE_SCHEMA = C.TABLE_SCHEMA
    AND B.CONSTRAINT_CATALOG = C.CONSTRAINT_CATALOG
    AND B.CONSTRAINT_SCHEMA = C.CONSTRAINT_SCHEMA
    AND B.CONSTRAINT_NAME = C.CONSTRAINT_NAME
	WHERE A.TABLE_NAME = @SrcTableName
		AND A.TABLE_SCHEMA = @SrcSchemaName
	ORDER BY A.ordinal_position

	OPEN @ColNames

	FETCH NEXT
	FROM @ColNames
	INTO @ColumnName
		,@isIdentity
		,@IsComputed
		,@DATA_TYPE

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @IsComputed = 0
			AND @DATA_TYPE <> 'timestamp'
		BEGIN
			SET @SourceInsertColumns = @SourceInsertColumns + CASE 
					WHEN @SourceInsertColumns = ''
						THEN ''
					ELSE ','
					END + 'S.' + '['+@ColumnName+']'
			SET @DestInsertColumns = @DestInsertColumns + CASE 
					WHEN @DestInsertColumns = ''
						THEN ''
					ELSE ','
					END + '['+@ColumnName+']'

			IF @isIdentity = 0
			BEGIN
				SET @UpdateClause = @UpdateClause + CASE 
						WHEN @UpdateClause = ''
							THEN ''
						ELSE ','
						END + '['+@ColumnName+']' + ' = ' + 'S.' + '['+@ColumnName+']' + CHAR(10)
			END

			IF @isIdentity = 1
				SET @identityColName = @ColumnName
		END

		FETCH NEXT
		FROM @ColNames
		INTO @ColumnName
			,@isIdentity
			,@IsComputed
			,@DATA_TYPE
	END

	CLOSE @ColNames

	DEALLOCATE @ColNames

	SET @sql = 'SET IDENTITY_INSERT ' + @SrcSchemaName+'.'+@SrcTableName + ' ON;
            MERGE ' + @TgtSchemaName+'.'+@TgtTableName + ' AS D
                USING ' + @SourceDB + @SrcSchemaName+'.'+@SrcTableName + ' AS S
                ON (D.' + @identityColName + ' = S.' + @identityColName + ')
            WHEN NOT MATCHED BY TARGET
                THEN INSERT(' + @DestInsertColumns + ') 
                VALUES(' + @SourceInsertColumns + ')
            WHEN MATCHED 
                THEN UPDATE SET 
                    ' + @UpdateClause + '
            WHEN NOT MATCHED BY SOURCE
                THEN DELETE
            OUTPUT $action, Inserted.*, Deleted.*;
			SELECT @@ROWCOUNT;
            SET IDENTITY_INSERT ' + @SrcSchemaName+'.'+@SrcTableName + ' OFF'

	PRINT @SQL
END

EXEC [dm].[GenerateMergeSQL] 'dm', 'dim_entity_master', 'dm', 'dim_entity_master'
