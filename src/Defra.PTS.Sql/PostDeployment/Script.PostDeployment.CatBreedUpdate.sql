/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               				
--------------------------------------------------------------------------------------
*/
GO
SET IDENTITY_INSERT [dbo].[Breed] ON 
GO
IF EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 81 AND [Name] = 'Leopard Cat (not a domestic breed)')
BEGIN
    DELETE from [dbo].[Breed] Where Id in (SELECT Id from [dbo].[Breed] WHERE [Name] = 'Leopard Cat (not a domestic breed)')	
END
GO