-- You can use this script when you need to duplicate tables in SQL server. For this case, I had to duplicate all the ticketmaster tables so that i could remove a column from them and not affect the original tables


-- Declare the database context
USE echlEverblades;

DECLARE @schemaName NVARCHAR(255);
DECLARE @tableName NVARCHAR(255);
DECLARE @newTableName NVARCHAR(255);
DECLARE @sqlCommand NVARCHAR(MAX);

-- Cursor to loop through the list of tables you want to duplicate
DECLARE table_cursor CURSOR FOR
SELECT TABLE_SCHEMA, TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES
WHERE CONCAT(TABLE_SCHEMA,'.',TABLE_NAME) IN (
    -- Edit this list based on the tables you need to duplicate
    'staging.arena',
    'staging.attendance',
    'staging.custRep',
    'staging.custemail',
    'staging.customer',
    'staging.customeraddress',
    'staging.event',
    'staging.journal',
    'staging.plans',
    'staging.pricecode',
    'staging.season',
    'staging.seatManifest',
    'staging.tex',
    'staging.ticket'
);

OPEN table_cursor;
FETCH NEXT FROM table_cursor INTO @schemaName, @tableName;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Create the new table name with '_migration' suffix
    SET @newTableName = @schemaName +'.' + @tableName + '_migration';

    -- Generate the SQL command for duplicating the table
    SET @sqlCommand = 'SELECT * INTO ' + @newTableName + ' FROM ' + @schemaName+'.'+@tableName;

    -- Print the SQL command for debugging
    PRINT @sqlCommand;

    -- Execute the SQL command
    EXEC sp_executesql @sqlCommand;

    -- Fetch the next table
    FETCH NEXT FROM table_cursor INTO @schemaName, @tableName;
END

-- Close and deallocate the cursor
CLOSE table_cursor;
DEALLOCATE table_cursor;
