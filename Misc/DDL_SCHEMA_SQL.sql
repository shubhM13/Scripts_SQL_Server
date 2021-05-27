--- Create Schema stg
IF NOT EXISTS ( SELECT  *
                FROM    sys.schemas
                WHERE   name = N'stg' )
    EXEC('CREATE SCHEMA [stg]');
GO
--- Create Schema dwh
IF NOT EXISTS ( SELECT  *
                FROM    sys.schemas
                WHERE   name = N'dwh' )
    EXEC('CREATE SCHEMA [dwh]');
GO
--- Create Schema dm 
IF NOT EXISTS ( SELECT  *
                FROM    sys.schemas
                WHERE   name = N'dm' )
    EXEC('CREATE SCHEMA [dm]');
GO