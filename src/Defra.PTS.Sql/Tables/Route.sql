CREATE TABLE [dbo].[Route] (
    [Id] INT PRIMARY KEY,
    [RouteName] NVARCHAR(300) NOT NULL,
    [DeparturePortId] INT NOT NULL,
    [ArrivalPortId] INT NOT NULL,
    [OperatorId] INT NOT NULL,
    FOREIGN KEY ([DeparturePortId]) REFERENCES [dbo].[Port]([Id]),
    FOREIGN KEY ([ArrivalPortId]) REFERENCES [dbo].[Port]([Id]),
    FOREIGN KEY ([OperatorId]) REFERENCES [dbo].[Operator]([Id])
);
