DECLARE @CheckSummaryTableColumnCount INT = 0;
DECLARE @CheckOutcomeTableColumnCount INT = 0;

SELECT @CheckSummaryTableColumnCount = COUNT(*)
FROM sys.columns
WHERE object_id = OBJECT_ID('dbo.CheckSummary');

SELECT @CheckOutcomeTableColumnCount = COUNT(*)
FROM sys.columns
WHERE object_id = OBJECT_ID('dbo.CheckOutcome');

IF @CheckSummaryTableColumnCount = 12 AND @CheckOutcomeTableColumnCount = 36
BEGIN

    DECLARE @OutcomeKeyNameSummaryTable NVARCHAR(200) = ''
    DECLARE @sql NVARCHAR(MAX) = '';

    SELECT 
       @OutcomeKeyNameSummaryTable =  fk.[name]
    FROM 
        sys.foreign_keys fk
    INNER JOIN 
        sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
    INNER JOIN 
        sys.columns c ON fkc.parent_object_id = c.object_id AND fkc.parent_column_id = c.column_id
    WHERE 
        fk.parent_object_id = OBJECT_ID('dbo.CheckSummary')
        AND c.name = 'CheckOutcomeId';

    SELECT @OutcomeKeyNameSummaryTable 

    -- If the constraint name was found, drop the constraint using dynamic SQL
    IF @OutcomeKeyNameSummaryTable IS NOT NULL AND @OutcomeKeyNameSummaryTable != ''
    BEGIN
        SET @sql = 'ALTER TABLE [dbo].[CheckSummary] DROP CONSTRAINT ' + QUOTENAME(@OutcomeKeyNameSummaryTable) + ';';
        EXEC sp_executesql @sql;
    END


    DECLARE @OutcomeKeyName NVARCHAR(200) = ''
    SET @sql = '';

    SELECT 
       @OutcomeKeyName =  fk.[name]
    FROM 
        sys.foreign_keys fk
    INNER JOIN 
        sys.foreign_key_columns fkc ON fk.object_id = fkc.constraint_object_id
    INNER JOIN 
        sys.columns c ON fkc.parent_object_id = c.object_id AND fkc.parent_column_id = c.column_id
    WHERE 
        fk.parent_object_id = OBJECT_ID('dbo.CheckOutcome')
        AND c.name = 'Outcome';

    SELECT @OutcomeKeyName 

    -- If the constraint name was found, drop the constraint using dynamic SQL
    IF @OutcomeKeyName IS NOT NULL AND @OutcomeKeyName != ''
    BEGIN
        SET @sql = 'ALTER TABLE [dbo].[CheckOutcome] DROP CONSTRAINT ' + QUOTENAME(@OutcomeKeyName) + ';';
        EXEC sp_executesql @sql;
    END



    TRUNCATE TABLE [dbo].[CheckSummary]
    TRUNCATE TABLE [dbo].[CheckOutcome]

    -- Step 4: Add foreign key constraints with specific names using dynamic SQL
    -- Add foreign key on CheckSummary table

    SET @sql = '
    ALTER TABLE [dbo].[CheckSummary]  
    WITH CHECK ADD CONSTRAINT ' + QUOTENAME(@OutcomeKeyNameSummaryTable) + ' 
    FOREIGN KEY([CheckOutcomeId]) 
    REFERENCES [dbo].[CheckOutcome] ([Id])';

    EXEC sp_executesql @sql;

    -- Add foreign key on CheckOutcome table

    SET @sql = '
    ALTER TABLE [dbo].[CheckOutcome]  
    WITH CHECK ADD CONSTRAINT ' + QUOTENAME(@OutcomeKeyName) + ' 
    FOREIGN KEY([Outcome])
    REFERENCES [dbo].[Outcome] ([Id])';

    EXEC sp_executesql @sql;

END



GO
IF NOT EXISTS (SELECT * FROM [dbo].[PasengerType] Where Id = 1 AND [Type] = 'Foot passenger')
BEGIN
	INSERT [dbo].[PasengerType] ([Id], [Type]) VALUES (1, N'Foot passenger')
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[PasengerType] Where Id = 2 AND [Type] = 'Vehicle')
BEGIN
	INSERT [dbo].[PasengerType] ([Id], [Type]) VALUES (2, N'Vehicle')
END
GO
