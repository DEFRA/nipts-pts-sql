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
IF EXISTS (SELECT * FROM [dbo].Colour WHERE SpeciesId = 1 and Name = 'Brown (chocolate, liver)')
BEGIN
	UPDATE Colour SET Name = 'Brown, tan or chocolate' WHERE SpeciesId = 1 and Name = 'Brown (chocolate, liver)';
END
GO

IF EXISTS (SELECT * FROM [dbo].Colour WHERE SpeciesId = 1 and Name = 'Grey (blue)')
BEGIN
	UPDATE Colour SET Name = 'Grey, silver or blue' WHERE SpeciesId = 1 and Name = 'Grey (blue)';
END
GO

IF EXISTS (SELECT * FROM [dbo].Colour WHERE SpeciesId = 1 and Name = 'White')
BEGIN
	UPDATE Colour SET Name = 'White, cream or sand' WHERE SpeciesId = 1 and Name = 'White';
END
GO


IF EXISTS (SELECT * FROM [dbo].Colour WHERE SpeciesId = 1 and Name = 'Golden')
BEGIN
	UPDATE Colour SET Name = 'Gold or yellow' WHERE SpeciesId = 1 and Name = 'Golden';
END
GO

IF EXISTS (SELECT * FROM [dbo].Colour WHERE SpeciesId = 1 and Name = 'Merle')
BEGIN
	UPDATE Colour SET Name = 'Merle (white flecks)' WHERE SpeciesId = 1 and Name = 'Merle';
END
GO

IF EXISTS (SELECT * FROM [dbo].Colour WHERE SpeciesId = 1 and Name = 'Merle')
BEGIN
	UPDATE Colour SET Name = 'Merle (white flecks)' WHERE SpeciesId = 1 and Name = 'Merle';
END
GO

IF EXISTS (SELECT * FROM [dbo].Colour WHERE SpeciesId = 2 and Name = 'Tabby (brown, silver, etc.)')
BEGIN
	UPDATE Colour SET Name = 'Tabby' WHERE SpeciesId = 2 and Name = 'Tabby (brown, silver, etc.)';
END
GO


IF EXISTS (SELECT * FROM [dbo].Colour WHERE SpeciesId = 2 and Name = 'Orange (ginger)')
BEGIN
	UPDATE Colour SET Name = 'Ginger' WHERE SpeciesId = 2 and Name = 'Orange (ginger)';
END
GO

IF EXISTS (SELECT * FROM [dbo].Colour WHERE SpeciesId = 2 and Name = 'Grey')
BEGIN
	UPDATE Colour SET Name = 'Grey or silver' WHERE SpeciesId = 2 and Name = 'Grey';
END
GO



IF NOT EXISTS (SELECT * FROM [dbo].Colour WHERE SpeciesId = 2 and Name = 'Tuxedo')
BEGIN
	INSERT INTO [dbo].[Colour] ([Name],[SpeciesId],[CreatedBy],[CreatedOn],[UpdatedBy],[UpdatedOn]) VALUES('Tuxedo',2,NULL,GETDATE(),NULL,GETDATE())
END
GO

IF EXISTS (SELECT * FROM [dbo].Pet WHERE ColourId = 9 and SpeciesId = 1)
BEGIN
	UPDATE Pet SET ColourId = 2 WHERE ColourId = 9 and SpeciesId = 1;
END
GO


IF EXISTS (SELECT * FROM [dbo].Pet WHERE ColourId = 4 and SpeciesId = 1)
BEGIN
	UPDATE Pet SET ColourId = 3 WHERE ColourId = 4 and SpeciesId = 1;
END
GO


IF EXISTS (SELECT * FROM [dbo].Pet WHERE ColourId = 18 and SpeciesId = 2)
BEGIN
	UPDATE Pet SET ColourId = 16 WHERE ColourId = 18 and SpeciesId = 2;
END
GO

IF EXISTS  (SELECT * from PetDocumentEvidence where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Fawn (white or sand)' AND SpeciesId = 1)))
BEGIN

    DELETE from PetDocumentEvidence where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Fawn (white or sand)' AND SpeciesId = 1))
END
GO

IF EXISTS  (SELECT * from TravelDocument where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Fawn (white or sand)' AND SpeciesId = 1)))
BEGIN

    DELETE from TravelDocument where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Fawn (white or sand)' AND SpeciesId = 1))
END
GO

IF EXISTS  (SELECT * from [Application] where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Fawn (white or sand)' AND SpeciesId = 1)))
BEGIN

    DELETE from [Application] where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Fawn (white or sand)' AND SpeciesId = 1))
END
GO

IF EXISTS  (SELECT * from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Fawn (white or sand)' AND SpeciesId = 1))
BEGIN

    DELETE FROM Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Fawn (white or sand)' AND SpeciesId = 1)	
END
GO

IF EXISTS  (SELECT * FROM [dbo].Colour WHERE Name = 'Fawn (white or sand)' AND SpeciesId = 1)
BEGIN
	DELETE FROM Colour WHERE Name = 'Fawn (white or sand)' AND SpeciesId = 1;
END
GO

IF EXISTS  (SELECT * from PetDocumentEvidence where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Tan' AND SpeciesId = 1)))
BEGIN

    DELETE from PetDocumentEvidence where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Tan' AND SpeciesId = 1))
END
GO

IF EXISTS  (SELECT * from TravelDocument where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Tan' AND SpeciesId = 1)))
BEGIN

    DELETE from TravelDocument where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Tan' AND SpeciesId = 1))
END
GO

IF EXISTS  (SELECT * from [Application] where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Tan' AND SpeciesId = 1)))
BEGIN

    DELETE from [Application] where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Tan' AND SpeciesId = 1))
END
GO

IF EXISTS  (SELECT * from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Tan' AND SpeciesId = 1))
BEGIN

    DELETE FROM Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Tan' AND SpeciesId = 1)	
END
GO

IF EXISTS  (SELECT * FROM [dbo].Colour WHERE Name = 'Tan' AND SpeciesId = 1)
BEGIN
	DELETE FROM Colour WHERE Name = 'Tan' AND SpeciesId = 1;
END
GO

IF EXISTS  (SELECT * from PetDocumentEvidence where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Siamese (seal point, blue point, etc.)' AND SpeciesId = 2)))
BEGIN

    DELETE from PetDocumentEvidence where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Siamese (seal point, blue point, etc.)' AND SpeciesId = 2))
END
GO

IF EXISTS  (SELECT * from TravelDocument where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Siamese (seal point, blue point, etc.)' AND SpeciesId = 2)))
BEGIN

    DELETE from TravelDocument where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Siamese (seal point, blue point, etc.)' AND SpeciesId = 2))
END
GO

IF EXISTS  (SELECT * from [Application] where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Siamese (seal point, blue point, etc.)' AND SpeciesId = 2)))
BEGIN

    DELETE from [Application] where PetId in (SELECT Id from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Siamese (seal point, blue point, etc.)' AND SpeciesId = 2))
END
GO

IF EXISTS  (SELECT * from Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Siamese (seal point, blue point, etc.)' AND SpeciesId = 2))
BEGIN

    DELETE FROM Pet where ColourId in( SELECT Id FROM [dbo].Colour WHERE Name = 'Siamese (seal point, blue point, etc.)' AND SpeciesId = 2)	
END
GO

IF EXISTS  (SELECT * FROM [dbo].Colour WHERE Name = 'Siamese (seal point, blue point, etc.)' AND SpeciesId = 2)
BEGIN
	DELETE FROM Colour WHERE Name = 'Siamese (seal point, blue point, etc.)' AND SpeciesId = 2;
END
GO
