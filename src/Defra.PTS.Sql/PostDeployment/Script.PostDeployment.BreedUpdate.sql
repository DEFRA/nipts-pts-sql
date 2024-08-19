/*
Post-Deployment Script Template							
--------------------------------------------------------------------------------------
 This file contains SQL statements that will be appended to the build script.		
 Use SQLCMD syntax to include a file in the post-deployment script.			
 Example:      :r .\myfile.sql								
 Use SQLCMD syntax to reference a variable in the post-deployment script.		
 Example:      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
GO
SET IDENTITY_INSERT [dbo].[Breed] ON 
GO
IF EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 99 AND [Name] = 'Mixed-breed or unknown')
BEGIN
	UPDATE [dbo].[Breed] SET [Name] = 'Mixed breed or unknown' WHERE [Name] = 'Mixed-breed or unknown'
END
GO

IF EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 100 AND [Name] = 'Mixed-breed or unknown')
BEGIN
	UPDATE [dbo].[Breed] SET [Name] = 'Mixed breed or unknown' WHERE [Name] = 'Mixed-breed or unknown'
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 99 AND [Name] = 'Mixed breed or unknown')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (99, N'Mixed breed or unknown', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 100 AND [Name] = 'Mixed breed or unknown')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (100, N'Mixed breed or unknown', 2)
END
GO