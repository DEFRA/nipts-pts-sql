﻿CREATE TABLE [dbo].[Organisation]
(
	[Id] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY DEFAULT NEWID(),
	[Name] NVARCHAR(300) NOT NULL,
	[ExternalId] UNIQUEIDENTIFIER NOT NULL
)
