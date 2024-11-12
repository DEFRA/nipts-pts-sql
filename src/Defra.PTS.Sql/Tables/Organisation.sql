﻿CREATE TABLE [dbo].[Organisation]
(
	[Id] UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
	[Name] NVARCHAR(300) NOT NULL,
	[Location] NVARCHAR(20) NOT NULL,
	[ExternalId] UNIQUEIDENTIFIER NULL,
	[ActiveFrom] DATETIME2(7) NULL,
	[ActiveTo] DATETIME2(7) NULL,
    [IsActive] BIT NOT NULL
)
