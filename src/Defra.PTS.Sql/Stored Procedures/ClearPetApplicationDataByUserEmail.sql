-- =============================================

-- Description					: Procedure to delete/clean application data using user email
-- @userEmail					: 'x.y@test.com,p.q@testing.com'
-- @IsDelete					: Bit Flag 0 --> Display data(readonly), 1 --> Performs the actual Delete action
-- =============================================
CREATE PROCEDURE [dbo].[ClearPetApplicationDataByUserEmail] 
	-- Add the parameters for the stored procedure here
	 @userEmail VARCHAR(MAX) = NULL,
	 @IsDelete BIT = 0
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	 DECLARE @applicationIds VARCHAR(MAX),
            @applicationOwnerIds VARCHAR(MAX),
            @applicationUserIds VARCHAR(MAX),
            @applicationPetIds VARCHAR(MAX),
            @applicationOwnerAddressIds VARCHAR(MAX),
            @ownerAddressIds VARCHAR(MAX),
            @userAddressIds VARCHAR(MAX),
			@travelDocumentIds VARCHAR(MAX);

    -- Initialize variables to empty strings
    SET @applicationIds = '';
    SET @applicationOwnerIds = '';
    SET @applicationUserIds = '';
    SET @applicationPetIds = '';
    SET @applicationOwnerAddressIds = '';
    SET @ownerAddressIds = '';
    SET @userAddressIds = '';
	SET @travelDocumentIds = '';

	IF @userEmail IS NOT NULL
	BEGIN
		SELECT
			@applicationUserIds = STUFF((SELECT DISTINCT ','  + CAST([UserId] AS VARCHAR(MAX)) 
									   FROM [dbo].[Application] 
									   WHERE UserId IN (SELECT Id FROM [dbo].[User] WHERE [Email] IN (SELECT value FROM STRING_SPLIT(@userEmail, ','))) 
									   FOR XML PATH('')), 1, 1, ''),
			@applicationOwnerIds = STUFF((SELECT DISTINCT ','  + CAST([OwnerId] AS VARCHAR(MAX)) 
									   FROM [dbo].[Application] 
									   WHERE UserId IN (SELECT Id FROM [dbo].[User] WHERE [Email] IN (SELECT value FROM STRING_SPLIT(@userEmail, ','))) 
									   FOR XML PATH('')), 1, 1, ''),
			@applicationPetIds = STUFF((SELECT DISTINCT ',' +  CAST([PetId] AS VARCHAR(MAX))
									   FROM [dbo].[Application] 
									   WHERE UserId IN (SELECT Id FROM [dbo].[User] WHERE [Email] IN (SELECT value FROM STRING_SPLIT(@userEmail, ','))) 
									   FOR XML PATH('')), 1, 1, ''),
			@applicationOwnerAddressIds = STUFF((SELECT DISTINCT ',' + CAST([OwnerAddressId] AS VARCHAR(MAX))
										   FROM [dbo].[Application] 
										   WHERE UserId IN (SELECT Id FROM [dbo].[User] WHERE [Email] IN (SELECT value FROM STRING_SPLIT(@userEmail, ',')))
										   FOR XML PATH('')), 1, 1, ''),
			@applicationIds = STUFF((SELECT DISTINCT ',' + CAST([Id] AS VARCHAR(MAX))
								FROM [dbo].[Application] 
								WHERE UserId IN (SELECT Id FROM [dbo].[User] WHERE [Email] IN (SELECT value FROM STRING_SPLIT(@userEmail, ',')))
								FOR XML PATH('')), 1, 1, '');

SELECT			@travelDocumentIds = STUFF((SELECT DISTINCT ',' + CAST([Id] AS VARCHAR(MAX))
                                   FROM [dbo].[TravelDocument]
                                   WHERE [ApplicationId] IN (SELECT value FROM STRING_SPLIT(@applicationIds, ','))
                                   FOR XML PATH('')), 1, 1, '');

		IF @applicationIds IS NOT NULL AND LEN(@applicationIds) > 0
		BEGIN

			PRINT 'Application Ids To Delete TravelDocument and Application: ' + @applicationOwnerIds
			IF @IsDelete = 0
			BEGIN
				SELECT * FROM [dbo].[TravelDocument] WHERE ApplicationId IN (SELECT value FROM STRING_SPLIT(@applicationIds, ','))
				SELECT * FROM [dbo].[Application] WHERE Id IN (SELECT value FROM STRING_SPLIT(@applicationIds, ','))
			END
			ELSE
			BEGIN
				DELETE FROM [dbo].TravelDocument WHERE ApplicationId IN (SELECT value FROM STRING_SPLIT(@applicationIds, ','))
				DELETE FROM [dbo].[Application] WHERE Id IN (SELECT value FROM STRING_SPLIT(@applicationIds, ','))
			END

			-- Handle Owner related data
			IF @applicationOwnerIds IS NOT NULL AND LEN(@applicationOwnerIds) > 0
			BEGIN
				SET @ownerAddressIds = STUFF((SELECT DISTINCT ',' + CAST([AddressId] AS VARCHAR(MAX))
						   FROM [dbo].[Owner] 
						   WHERE Id IN  (SELECT value FROM STRING_SPLIT(@applicationOwnerIds, ',')) 
						   FOR XML PATH('')), 1, 1, '')
				 PRINT 'Owner Ids To Delete: ' + @applicationOwnerIds;

				IF @IsDelete = 0
				BEGIN
					SELECT * FROM [dbo].[Owner] WHERE Id IN (SELECT value FROM STRING_SPLIT(@applicationOwnerIds, ','))
				END
				ELSE
				BEGIN
					DELETE FROM [dbo].[Owner] WHERE Id IN (SELECT value FROM STRING_SPLIT(@applicationOwnerIds, ','))
				END
			END

			IF @ownerAddressIds IS NOT NULL AND LEN(@ownerAddressIds) > 0
			BEGIN
				PRINT 'Owner Address Ids To Delete : ' + @ownerAddressIds
				IF @IsDelete = 0
				BEGIN
					SELECT * FROM [dbo].[Address] WHERE Id IN (SELECT value FROM STRING_SPLIT(@ownerAddressIds, ','))
				END
				ELSE
				BEGIN
					DELETE FROM [dbo].[Address] WHERE Id IN (SELECT value FROM STRING_SPLIT(@ownerAddressIds, ','))
				END
			END

			-- Handle ApplicationOwnerAddress related data
			IF @applicationOwnerAddressIds IS NOT NULL AND LEN(@applicationOwnerAddressIds) > 0
			BEGIN
				PRINT 'Application Owner Address Ids To Delete : ' + @applicationOwnerAddressIds
				IF @IsDelete = 0
				BEGIN
					SELECT * FROM [dbo].[Address] WHERE Id IN (SELECT value FROM STRING_SPLIT(@applicationOwnerAddressIds, ','))
				END
				ELSE
				BEGIN
					DELETE FROM [dbo].[Address] WHERE Id IN (SELECT value FROM STRING_SPLIT(@applicationOwnerAddressIds, ','))
				END
			END


			IF @applicationUserIds IS NOT NULL AND LEN(@applicationUserIds) > 0
			BEGIN
				SET @userAddressIds = STUFF((SELECT DISTINCT ',' + CAST([AddressId] AS VARCHAR(MAX))
						   FROM [dbo].[User] 
						   WHERE Id IN  (SELECT value FROM STRING_SPLIT(@applicationUserIds, ',')) 
						   FOR XML PATH('')), 1, 1, '')

				PRINT 'Application User Ids To Delete : ' + @applicationUserIds
				IF @IsDelete = 0
				BEGIN
					SELECT * FROM [dbo].[User] WHERE Id IN (SELECT value FROM STRING_SPLIT(@applicationUserIds, ','))
				END
				ELSE
				BEGIN
					DELETE FROM [dbo].[User] WHERE Id IN (SELECT value FROM STRING_SPLIT(@applicationUserIds, ','))
				END
			END

			IF @userAddressIds IS NOT NULL AND LEN(@userAddressIds) > 0
			BEGIN
				PRINT 'Users AddressIds To Delete : ' + @userAddressIds
				IF @IsDelete = 0
				BEGIN
					SELECT * FROM [dbo].[Address] WHERE Id IN (SELECT value FROM STRING_SPLIT(@userAddressIds, ','))
				END
				ELSE
				BEGIN
					DELETE FROM [dbo].[Address] WHERE Id IN (SELECT value FROM STRING_SPLIT(@userAddressIds, ','))
				END
			END


			IF @applicationPetIds IS NOT NULL AND LEN(@applicationPetIds) > 0
			BEGIN
				PRINT 'Ped Ids To Delete : ' + @applicationPetIds
				IF @IsDelete = 0
				BEGIN
					SELECT * FROM [dbo].[Pet] WHERE Id IN (SELECT value FROM STRING_SPLIT(@applicationPetIds, ','))
				END
				ELSE
				BEGIN
					DELETE FROM [dbo].[Pet] WHERE Id IN (SELECT value FROM STRING_SPLIT(@applicationPetIds, ','))
				END
			END
		END
	END
END



