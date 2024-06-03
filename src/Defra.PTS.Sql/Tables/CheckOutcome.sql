﻿CREATE TABLE [dbo].[CheckOutcome] (
    Id UNIQUEIDENTIFIER PRIMARY KEY,
    GBCheck bit NULL,
    CheckOutcome bit NULL,
    PTDFailNoPTD bit NULL,
    PTDFailStatusAwaitingApproval bit NULL,
    PTDFailStatusUnsuccessfulRevokedSuspended bit NULL,
    PTDFailOther bit NULL,
    PTDFailOtherDetail nvarchar(300) NULL,
    MCFailNotFound bit NULL,
    MCFailScannerIssue bit NULL,
    VCFailSpecies bit NULL,
    VCFailSpeciesActual nvarchar(300) NULL,
    VCFailBreed bit NULL,
    VCFailBreedActual int NULL,
    VCFailColour bit NULL,
    VCFailColourActual int NULL,
    VCFailFeatures bit NULL,
    VCFailFeaturesActual nvarchar(300) NULL,
    OIFailAHCExpInv bit NULL,
    OIFailCommercial bit NULL,
    OIFailCommercialLorry int NULL,
    OIFailCommercialNotInLane int NULL,
    OIFailCommercialLogos int NULL,
    OIFailCommercialComments nvarchar(300) NULL,
    OIFailRefusedChecks bit NULL,
    OIFailRefusedChecksDetail nvarchar(300) NULL,
    OIFailOther bit NULL,
    OIFailOtherDetail nvarchar(300) NULL,
    PDSpecies bit NULL,
    PDBreed int NULL,
    PDColour int NULL,
    PDFeatures nvarchar(300) NULL,
    ODType int NULL,
    ODComments nvarchar(300) NULL,
    Outcome int NULL,
    OutcomeAdvNotTravelTravelled int NULL,
    OutcomeAdvNotTravelNotTravelled int NULL,
    OutcomeAdvNotTravelNotSay int NULL,
    FOREIGN KEY (Outcome) REFERENCES [dbo].[Outcome]([Id]),
    FOREIGN KEY (ODType) REFERENCES [dbo].[PasengerType]([Id]),
    FOREIGN KEY (VCFailBreedActual) REFERENCES [dbo].[Breed]([Id]),
    FOREIGN KEY (PDBreed) REFERENCES [dbo].[Breed]([Id]),    
    FOREIGN KEY (VCFailColourActual) REFERENCES [dbo].[Colour]([Id]),
    FOREIGN KEY (PDColour) REFERENCES [dbo].[Colour]([Id]),
    FOREIGN KEY (VCFailColourActual) REFERENCES [dbo].[Colour]([Id]),
    FOREIGN KEY (PDColour) REFERENCES [dbo].[Colour]([Id]),
);