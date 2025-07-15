
-- Remove unique constraint from Owner table to allow multiple owners with same email
IF EXISTS (
    SELECT 1 
    FROM sys.key_constraints 
    WHERE name = 'UK_OwnerEmail' 
    AND parent_object_id = OBJECT_ID('dbo.Owner')
)
BEGIN
    ALTER TABLE [dbo].[Owner] DROP CONSTRAINT [UK_OwnerEmail]
END
GO