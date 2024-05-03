CREATE VIEW [dbo].[VwApplications]
AS
    SELECT
        app.[Id] AS [ApplicationId],
        app.[ReferenceNumber],
        app.[Status],
        app.[DateOfApplication],

        -- User
        app.[UserId],
        u.[FullName] AS [UserFullName],
        u.[Email] AS [UserEmail],

        -- Owner
        app.[OwnerId],
        app.[OwnerNewName] AS [OwnerName],
        o.[Email] AS [OwnerEmail],
        app.[OwnerNewTelephone] AS [OwnerPhoneNumber],
        o.[AddressId] AS [OwnerAddressId],
        a.[AddressLineOne] AS [OwnerAddressLineOne],
        a.[AddressLineTwo] AS [OwnerAddressLineTwo],
        a.[TownOrCity] AS [OwnerTownOrCity],
        a.[County] AS [OwnerCounty],
        a.[PostCode] AS [OwnerPostcode],

        -- Pet
        app.[PetId],
        p.[Name] AS [PetName],
        p.[SpeciesId] [PetSpeciesId],
        p.[BreedId] [PetBreedId],
        b.[Name] [PetBreedName],
        p.[AdditionalInfoMixedBreedOrUnknown] [PetBreedOther],
        p.[SexId] [PetGenderId],
        p.[DOB] [PetBirthDate],
        p.[ColourId] [PetColourId],
        c.[Name] [PetColourName],
        p.[OtherColour] [PetColourOther],
        p.[HasUniqueFeature] [PetHasUniqueFeature],
        p.[UniqueFeatureDescription] [PetUniqueFeature],

        -- Microchip
        p.MicrochipNumber,
        p.MicrochippedDate,

		-- Certificate
		td.[DocumentReferenceNumber],
        app.[DateAuthorised] [DocumentIssueDate],
		td.[DocumentSignedBy]

    FROM
        dbo.[Application] AS app
        INNER JOIN
            dbo.[Owner] AS o
                ON app.OwnerId = o.Id
        INNER JOIN
            dbo.Pet AS p
                ON app.PetId = p.Id
        INNER JOIN
            dbo.[User] AS u
                ON app.UserId = u.Id
        LEFT OUTER JOIN
            dbo.[Breed] AS b
                ON p.BreedId = b.Id
        LEFT OUTER JOIN
            dbo.[Colour] AS c
                ON p.ColourId = c.Id
        LEFT OUTER JOIN
            dbo.[Address] AS a
                ON app.OwnerAddressId = a.Id
        LEFT OUTER JOIN
            dbo.[TravelDocument] AS td
                ON app.Id = td.ApplicationId
