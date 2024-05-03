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
IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 1 AND [Name] = 'Chihuahua')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (1, N'Chihuahua', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 2 AND [Name] = 'Pekingese')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (2, N'Pekingese', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 3 AND [Name] = 'Pomeranian')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (3, N'Pomeranian', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 4 AND [Name] = 'Toy Poodle')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (4, N'Toy Poodle', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 5 AND [Name] = 'Italian Greyhound')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (5, N'Italian Greyhound', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 6 AND [Name] = 'Shih Tzu')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (6, N'Shih Tzu', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 7 AND [Name] = 'Papillon')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (7, N'Papillon', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 8 AND [Name] = 'Cavalier King Charles Spaniel')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (8, N'Cavalier King Charles Spaniel', 1)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 9 AND [Name] = 'Afghan Hound')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (9, N'Afghan Hound', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 10 AND [Name] = 'Basset Hound')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (10, N'Basset Hound', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 11 AND [Name] = 'Beagle')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (11, N'Beagle', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 12 AND [Name] = 'Bloodhound')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (12, N'Bloodhound', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 13 AND [Name] = 'Borzoi')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (13, N'Borzoi', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 14 AND [Name] = 'Dachshund')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (14, N'Dachshund', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 15 AND [Name] = 'Greyhound')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (15, N'Greyhound', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 16 AND [Name] = 'Whippet')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (16, N'Whippet', 1)
END
GO



IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 17 AND [Name] = 'Cocker Spaniel')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (17, N'Cocker Spaniel', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 18 AND [Name] = 'English Setter')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (18, N'English Setter', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 19 AND [Name] = 'German Shorthaired Pointer')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (19, N'German Shorthaired Pointer', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 20 AND [Name] = 'Golden Retriever')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (20, N'Golden Retriever', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 21 AND [Name] = 'Irish Setter')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (21, N'Irish Setter', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 22 AND [Name] = 'Labrador Retriever')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (22, N'Labrador Retriever', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 23 AND [Name] = 'Vizsla')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (23, N'Vizsla', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 24 AND [Name] = 'Weimaraner')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (24, N'Weimaraner', 1)
END
GO



IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 25 AND [Name] = 'Boxer')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (25, N'Boxer', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 26 AND [Name] = 'Doberman Pinscher')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (26, N'Doberman Pinscher', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 27 AND [Name] = 'Great Dane')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (27, N'Great Dane', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 28 AND [Name] = 'Mastiff')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (28, N'Mastiff', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 29 AND [Name] = 'Rottweiler')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (29, N'Rottweiler', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 30 AND [Name] = 'Siberian Husky')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (30, N'Siberian Husky', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 31 AND [Name] = 'Saint Bernard')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (31, N'Saint Bernard', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 32 AND [Name] = 'Alaskan Malamute')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (32, N'Alaskan Malamute', 1)
END
GO




IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 33 AND [Name] = 'Airedale Terrier')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (33, N'Airedale Terrier', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 34 AND [Name] = 'Bull Terrier')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (34, N'Bull Terrier', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 35 AND [Name] = 'Cairn Terrier')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (35, N'Cairn Terrier', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 36 AND [Name] = 'Fox Terrier')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (36, N'Fox Terrier', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 37 AND [Name] = 'Irish Terrier')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (37, N'Irish Terrier', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 38 AND [Name] = 'Jack Russell Terrier')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (38, N'Jack Russell Terrier', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 39 AND [Name] = 'Scottish Terrier')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (39, N'Scottish Terrier', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 40 AND [Name] = 'West Highland White Terrier')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (40, N'West Highland White Terrier', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 41 AND [Name] = 'Bulldog')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (41, N'Bulldog', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 42 AND [Name] = 'Chow Chow')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (42, N'Chow Chow', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 43 AND [Name] = 'Dalmatian')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (43, N'Dalmatian', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 44 AND [Name] = 'French Bulldog')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (44, N'French Bulldog', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 45 AND [Name] = 'Lhasa Apso')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (45, N'Lhasa Apso', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 46 AND [Name] = 'Poodle (Standard and Miniature)')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (46, N'Poodle (Standard and Miniature)', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 47 AND [Name] = 'Shar Pei')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (47, N'Shar Pei', 1)
END
GO



IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 48 AND [Name] = 'Australian Shepherd')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (48, N'Australian Shepherd', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 49 AND [Name] = 'Border Collie')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (49, N'Border Collie', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 50 AND [Name] = 'Collie')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (50, N'Collie', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 51 AND [Name] = 'German Shepherd')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (51, N'German Shepherd', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 52 AND [Name] = 'Old English Sheepdog')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (52, N'Old English Sheepdog', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 53 AND [Name] = 'Shetland Sheepdog')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (53, N'Shetland Sheepdog', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 54 AND [Name] = 'Belgian Malinois')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (54, N'Belgian Malinois', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 55 AND [Name] = 'Corgi (Pembroke and Cardigan)')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (55, N'Corgi (Pembroke and Cardigan)', 1)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 56 AND [Name] = 'Basenji')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (56, N'Basenji', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 57 AND [Name] = 'Belgian Tervuren')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (57, N'Belgian Tervuren', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 58 AND [Name] = 'Bernese Mountain Dog')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (58, N'Bernese Mountain Dog', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 59 AND [Name] = 'Bichon Frise')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (59, N'Bichon Frise', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 60 AND [Name] = 'Boston Terrier')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (60, N'Boston Terrier', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 61 AND [Name] = 'Newfoundland')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (61, N'Newfoundland', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 62 AND [Name] = 'Samoyed')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (62, N'Samoyed', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 63 AND [Name] = 'Portuguese Water Dog')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (63, N'Portuguese Water Dog', 1)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 64 AND [Name] = 'Pug')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (64, N'Pug', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 65 AND [Name] = 'Cockapoo')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (65, N'Cockapoo', 1)
END
GO

/*cats data*/

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 66 AND [Name] = 'Domestic Shorthair')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (66, N'Domestic Shorthair', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 67 AND [Name] = 'Domestic Longhair')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (67, N'Domestic Longhair', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 68 AND [Name] = 'Domestic Mediumhair')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (68, N'Domestic Mediumhair', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 69 AND [Name] = 'Persian')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (69, N'Persian', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 70 AND [Name] = 'Exotic Shorthair')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (70, N'Exotic Shorthair', 2)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 71 AND [Name] = 'Siamese')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (71, N'Siamese', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 72 AND [Name] = 'Oriental Shorthair')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (72, N'Oriental Shorthair', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 73 AND [Name] = 'Oriental Longhair')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (73, N'Oriental Longhair', 2)
END
GO



IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 74 AND [Name] = 'Maine Coon')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (74, N'Maine Coon', 2)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 75 AND [Name] = 'British Shorthair')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (75, N'British Shorthair', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 76 AND [Name] = 'American Shorthair')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (76, N'American Shorthair', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 77 AND [Name] = 'Norwegian Forest Cat')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (77, N'Norwegian Forest Cat', 2)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 78 AND [Name] = 'Bengal')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (78, N'Bengal', 2)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 79 AND [Name] = 'Ocicat')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (79, N'Ocicat', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 80 AND [Name] = 'Savannah')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (80, N'Savannah', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 81 AND [Name] = 'Leopard Cat (not a domestic breed)')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (81, N'Leopard Cat (not a domestic breed)', 2)
END
GO



IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 82 AND [Name] = 'Russian Blue')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (82, N'Russian Blue', 2)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 83 AND [Name] = 'Sphynx')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (83, N'Sphynx', 2)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 84 AND [Name] = 'Scottish Fold')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (84, N'Scottish Fold', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 85 AND [Name] = 'Devon Rex')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (85, N'Devon Rex', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 86 AND [Name] = 'Cornish Rex')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (86, N'Cornish Rex', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 87 AND [Name] = 'Ragdoll')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (87, N'Ragdoll', 2)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 88 AND [Name] = 'Birman')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (88, N'Birman', 2)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 89 AND [Name] = 'Himalayan')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (89, N'Himalayan', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 90 AND [Name] = 'Scottish Fold Longhair')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (90, N'Scottish Fold Longhair', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 91 AND [Name] = 'Siberian')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (91, N'Siberian', 2)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 92 AND [Name] = 'Abyssinian')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (92, N'Abyssinian', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 93 AND [Name] = 'Burmese')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (93, N'Burmese', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 94 AND [Name] = 'Chartreux')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (94, N'Chartreux', 2)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 95 AND [Name] = 'Tonkinese')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (95, N'Tonkinese', 2)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 96 AND [Name] = 'Turkish Angora')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (96, N'Turkish Angora', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 97 AND [Name] = 'Turkish Van')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (97, N'Turkish Van', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Breed] Where Id = 98 AND [Name] = 'Manx')
BEGIN
	INSERT [dbo].[Breed] ([Id], [Name], [SpeciesId]) VALUES (98, N'Manx', 2)
END
GO

SET IDENTITY_INSERT [dbo].[Breed] OFF
GO


GO
SET IDENTITY_INSERT [dbo].[Colour] ON 
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 1 AND [Name] = 'Black')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (1, N'Black', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 2 AND [Name] = 'White')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (2, N'White', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 3 AND [Name] = 'Brown (chocolate, liver)')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (3, N'Brown (chocolate, liver)', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 4 AND [Name] = 'Tan')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (4, N'Tan', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 5 AND [Name] = 'Grey (blue)')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (5, N'Grey (blue)', 1)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 6 AND [Name] = 'Red')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (6, N'Red', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 7 AND [Name] = 'Golden')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (7, N'Golden', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 8 AND [Name] = 'Brindle (tiger stripes)')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (8, N'Brindle (tiger stripes)', 1)
END
GO



IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 9 AND [Name] = 'Fawn (white or sand)')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (9, N'Fawn (white or sand)', 1)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 10 AND [Name] = 'Merle')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (10, N'Merle', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 11 AND [Name] = 'Other')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (11, N'Other', 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 12 AND [Name] = 'Black')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (12, N'Black', 2)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 13 AND [Name] = 'White')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (13, N'White', 2)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 14 AND [Name] = 'Grey')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (14, N'Grey', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 15 AND [Name] = 'Orange (ginger)')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (15, N'Orange (ginger)', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 16 AND [Name] = 'Calico')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (16, N'Calico', 2)
END
GO



IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 17 AND [Name] = 'Tortoiseshell')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (17, N'Tortoiseshell', 2)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 18 AND [Name] = 'Siamese (seal point, blue point, etc.)')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (18, N'Siamese (seal point, blue point, etc.)', 2)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 19 AND [Name] = 'Tabby (brown, silver, etc.)')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (19, N'Tabby (brown, silver, etc.)', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 20 AND [Name] = 'Other')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (20, N'Other', 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 21 AND [Name] = 'Sable')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (21, N'Sable', 3)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 22 AND [Name] = 'White (albino)')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (22, N'White (albino)', 3)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 23 AND [Name] = 'Black')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (23, N'Black', 3)
END
GO


IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 24 AND [Name] = 'Black sable')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (24, N'Black sable', 3)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 25 AND [Name] = 'Chocolate')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (25, N'Chocolate', 3)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 26 AND [Name] = 'Cinnamon')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (26, N'Cinnamon', 3)
END
GO



IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 27 AND [Name] = 'Champagne')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (27, N'Champagne', 3)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 28 AND [Name] = 'Silver')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (28, N'Silver', 3)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Colour] Where Id = 29 AND [Name] = 'Other')
BEGIN
	INSERT [dbo].[Colour] ([Id], [Name], [SpeciesId]) VALUES (29, N'Other', 3)
END
GO

SET IDENTITY_INSERT [dbo].[Colour] OFF
GO

