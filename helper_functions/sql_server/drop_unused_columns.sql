--  use this script to drop specific columns from the tables specified on line 17-30
-- MAKE SURE NOT TO ADD THE ORIGINAL TALBES!!!

 
 
 -- Declare the database context
USE echlEverblades;

DECLARE @schemaName NVARCHAR(255);
DECLARE @tableName NVARCHAR(255);
DECLARE @sqlCommand NVARCHAR(MAX);
DECLARE @columnName NVARCHAR(255);

-- Cursor to loop through the list of tables you want to modify
DECLARE table_cursor CURSOR FOR
SELECT TABLE_SCHEMA, TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES
WHERE CONCAT(TABLE_SCHEMA, '.', TABLE_NAME) IN (
    -- EDit this list to include the tables that you need to drop columns for
    --  DO NOT USE THE ORIGINAL TALBES!!!
    'staging.arena_migration',
    'staging.attendance_migration',
    'staging.custRep_migration',
    'staging.custemail_migration',
    'staging.customer_migration',
    'staging.customeraddress_migration',
    'staging.event_migration',
    'staging.journal_migration',
    'staging.plans_migration',
    'staging.pricecode_migration',
    'staging.season_migration',
    'staging.seatManifest_migration',
    'staging.tex_migration',
    'staging.ticket_migration'
);

OPEN table_cursor;
FETCH NEXT FROM table_cursor INTO @schemaName, @tableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Check if the 'ingestion_datetime' column exists
    IF EXISTS (
        SELECT 1 
        FROM INFORMATION_SCHEMA.COLUMNS 
        WHERE TABLE_SCHEMA = @schemaName 
          AND TABLE_NAME = @tableName 
          AND COLUMN_NAME = 'ingestion_datetime'
    )
    BEGIN
        -- Drop the 'ingestion_datetime' column
        SET @sqlCommand = 'ALTER TABLE ' + @schemaName + '.' + @tableName + ' DROP COLUMN ingestion_datetime';
        PRINT 'Dropping column ingestion_datetime from ' + @schemaName + '.' + @tableName;
        EXEC sp_executesql @sqlCommand;
    END

    -- Check if the 'ingestion_property' column exists
    IF EXISTS (
        SELECT 1 
        FROM INFORMATION_SCHEMA.COLUMNS 
        WHERE TABLE_SCHEMA = @schemaName 
          AND TABLE_NAME = @tableName 
          AND COLUMN_NAME = 'ingestion_property'
    )
    BEGIN
        -- Drop the 'ingestion_property' column
        SET @sqlCommand = 'ALTER TABLE ' + @schemaName + '.' + @tableName + ' DROP COLUMN ingestion_property';
        PRINT 'Dropping column ingestion_property from ' + @schemaName + '.' + @tableName;
        EXEC sp_executesql @sqlCommand;
    END

    -- Fetch the next table
    FETCH NEXT FROM table_cursor INTO @schemaName, @tableName;
END

-- Close and deallocate the cursor
CLOSE table_cursor;
DEALLOCATE table_cursor;
