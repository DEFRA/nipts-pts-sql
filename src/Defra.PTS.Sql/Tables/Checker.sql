CREATE TABLE [dbo].[Checker] (
    [Id] UNIQUEIDENTIFIER PRIMARY KEY,
    [FullName] NVARCHAR(300),
    [FirstName] NVARCHAR(300),
    [LastName] NVARCHAR(300),
    [Role] INT,
    [PortLocation] NVARCHAR(300),
    FOREIGN KEY ([Role]) REFERENCES [dbo].[Role]([Id])
);
