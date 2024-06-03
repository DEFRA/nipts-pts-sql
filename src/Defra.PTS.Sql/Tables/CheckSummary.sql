CREATE TABLE [dbo].[CheckSummary] (
    Id uniqueidentifier PRIMARY KEY,
    GBCheck bit,
    LinkedCheckId uniqueidentifier,
    CheckerId uniqueidentifier,
    [Route] int,
    [Date] date,
    ScheduledSailingTime time,
    ApplicationId uniqueidentifier,
    TravelDocumentId uniqueidentifier,
    ChipNumber nvarchar(15),
    OwnerId uniqueidentifier,
    CheckOutcomeId uniqueidentifier,
    PTDFailStatusAwaitingApproval bit,
    PTDFailStatusUnsuccessfulRevokedSuspended bit
    FOREIGN KEY (CheckOutcomeId) REFERENCES [dbo].[CheckOutcome]([Id]),
    FOREIGN KEY (OwnerId) REFERENCES [dbo].[Owner]([Id]),
    FOREIGN KEY ([ApplicationId]) REFERENCES [dbo].[Application]([Id]),
    FOREIGN KEY ([TravelDocumentId]) REFERENCES [dbo].[TravelDocument]([Id]),
    FOREIGN KEY ([Route]) REFERENCES [dbo].[Route]([Id]),
    FOREIGN KEY (CheckerId) REFERENCES [dbo].[Checker]([Id]),
    FOREIGN KEY (LinkedCheckId) REFERENCES [dbo].[CheckSummary]([Id]),
    
);
