CREATE TABLE [dbo].[Route] (
    [Id] INT PRIMARY KEY,
    [RouteName] NVARCHAR(300) NOT NULL,
    [DeparturePort] INT NOT NULL,
    [ArrivalPort] INT NOT NULL,
    [Operator] INT NOT NULL,
    FOREIGN KEY ([DeparturePort]) REFERENCES [dbo].[Port]([Id]),
    FOREIGN KEY ([ArrivalPort]) REFERENCES [dbo].[Port]([Id]),
    FOREIGN KEY ([Operator]) REFERENCES [dbo].[Operator]([Id])
);
