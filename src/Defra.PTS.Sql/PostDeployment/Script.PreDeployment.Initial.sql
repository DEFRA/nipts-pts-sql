/*
 Pre-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be executed before the build script.	
 Use SQLCMD syntax to include a file in the pre-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the pre-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
GO
DELETE FROM [dbo].[Address]      
GO
DELETE FROM [dbo].[TravelDocument]
GO
DELETE FROM [dbo].[PetDocumentEvidence]
GO
DELETE FROM [dbo].[Application]      
GO
DELETE FROM [dbo].[Pet]      
GO
DELETE FROM [dbo].[User]      
GO
DELETE FROM [dbo].[Owner]      
GO
DELETE FROM [dbo].[Colour]      
GO
DELETE FROM [dbo].[Breed]      
GO
DECLARE @PkConstraintName NVARCHAR(400)
SELECT
   @PkConstraintName = constraint_name
FROM
    information_schema.table_constraints
WHERE
    table_name = 'Address'
AND constraint_type = 'PRIMARY KEY';
EXEC('ALTER TABLE [dbo].[Address] DROP CONSTRAINT ' + @PkConstraintName)
GO
ALTER TABLE [dbo].[Address] DROP COLUMN [Id]
GO
ALTER TABLE [dbo].[Address] ADD [Id] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID()
GO



