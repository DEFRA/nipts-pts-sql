﻿CREATE TABLE [dbo].[Signatories] (
    ID UNIQUEIDENTIFIER PRIMARY KEY,
    Name NVARCHAR(250) NOT NULL,
    Title NVARCHAR(100) NOT NULL,
    ValidFrom DATETIME NOT NULL,
    ValidTo DATETIME NOT NULL,
    SignatureImage VARBINARY(MAX),
    CreatedBy NVARCHAR(100) NOT NULL,
    CreatedOn DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedBy NVARCHAR(100),
    UpdatedOn DATETIME
);