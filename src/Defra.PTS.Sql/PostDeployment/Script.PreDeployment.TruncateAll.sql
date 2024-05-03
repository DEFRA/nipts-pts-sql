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
--GO
--DELETE FROM [dbo].[User]
--GO
--DELETE FROM [dbo].[Owner]
--GO
DELETE FROM [dbo].[Address]
Go
DROP TABLE [dbo].[Application]
GO
DELETE FROM [dbo].[Pet]
Go
--GO
--DROP TABLE [dbo].[Breed]
--GO
--DROP TABLE [dbo].[Colour]
--GO


--DROP TABLE [dbo].[PetDocumentEvidence]
--GO
--DROP TABLE [dbo].[TravelDocument]
--GO


