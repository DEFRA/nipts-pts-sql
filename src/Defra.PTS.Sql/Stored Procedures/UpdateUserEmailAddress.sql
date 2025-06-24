-- =============================================
-- Author:      Stuart Gadsby
-- Create Date: 08/05/2025
-- Description: Update User and Owner Email when a user changes their email address
-- ============================================
-- Enter the user's old email address and new email address.
-- Use the IsUpdate BIT to indicate whether the this script only does an initial
-- check and reports info, or also makes the changes to correct the email address
-- Do not set the BIT to only run the check, set the BIT to 1 to also make the change
-- In both cases the check is done and information is reported in the messages along
-- with the following found rows from the database:
-- - Users from the Users table that have the same IDM ID as the original email (there
--   should be two rows, one for the old email and one for the new.
-- - Owners from the Owners table that have either the old or the new email address
--   (there should only be one; if there is more than one, it would indicate that the
--   user has submitted an application under the new email address and they may now have
--   applciations under both, whihc would need tidying up in a different way.
-- - Applications made under the old email address
-- - Applications made under the new email address (If there are any, the script will not
--   let you change the run the update process.
-- If making the change, the script will only make the change if the followng is true:
-- - There are two users found in the Users table with the same ID from IDM
-- - There is only one owner found and linked to the old email address
-- - There are no owners or applications linked to the new email address
-- =============================================
CREATE PROCEDURE [dbo].[UpdateUserEmailAddress]
(
    -- Add the parameters for the stored procedure here
    @OldEmail nvarchar(100) = NULL,
    @NewEmail nvarchar(100) = NULL,
	@IsUpdate BIT = 0
)
AS
BEGIN
-- Pre Checks. These will always run and output the info, even if you are updating.
		DECLARE @ParametersDefined BIT = 0;
		DECLARE @FoundUsers int = NULL;
		DECLARE @FoundOwners int = NULL;
		DEClaRE @FoundNewOwners int = NULL;
		DECLARE @FoundOldEmailApplications int = NULL;
		DECLARE @FoundNewEmailApplications int = NULL;
		DECLARE @SafeToProceed BIT = 0;
		DECLARE @NewUserId NVARCHAR(100) = NULL;
		DECLARE @OldUserId NVARCHAR(100) = NULL;
		DECLARE @OwnerId NVARCHAR(100) = NULL;
		

		 SET NOCOUNT ON

		IF (@OldEmail IS NOT NULL) AND (@NewEmail IS NOT NULL)
			SET @ParametersDefined = 1
			ELSE
			SET @ParametersDefined = 0

		IF (@ParametersDefined = 0)
		BEGIN
		PRINT 'Both old email and new email addresses are required';
		END
		ELSE IF (@ParametersDefined = 1)
		BEGIN
			-- Find the users that share the same IDM ID based on the old email - there should be two, one with the old email, one with the new.
			SELECT *
			FROM [User]
			WHERE UniqueReference IN (SELECT UniqueReference FROM [User] WHERE Email = @OldEmail)

			-- Write the Id of the New User to a varibale for later
			SELECT @NewUserId = [Id] FROM [User] WHERE Email = @NewEmail

			-- Write the Id of the Old User to a varibale for later
			SELECT @OldUserId = [Id] FROM [User] WHERE Email = @OldEmail

			-- Write the number of found users into a variable for use with checks later on
			SELECT @FoundUsers = COUNT(*)
			FROM [user]
			WHERE UniqueReference IN (SELECT UniqueReference FROM [User] WHERE Email = @OldEmail)

			-- There should only be one owner record, which would be linked to the old email ID. If an additional owner record is found that is linked to the new ID< then there may be applications linked to the new email
			SELECT *
			FROM [Owner]
			WHERE Email = @OldEmail OR Email = @NewEmail

			--Write the number of found owners into a variable for user with checks later on
			SELECT @FoundOwners = COUNT(*) FROM [Owner]
			WHERE Email = @OldEmail OR Email = @NewEmail

			-- Write the number of owners found using the new email into a variable for checks later on (there should be none)
			SELECT @FoundNewOwners = COUNT(*) FROM [Owner]
			WHERE Email = @NewEmail
			
			-- Write the Id of the OwnerID for the old email to a varibale for later
			SELECT @OwnerId = [Id] FROM [Owner] WHERE Email = @OldEmail

			-- Check for applications for the old email address
			SELECT *
			FROM [Application]
			WHERE UserId IN (SELECT Id FROM [User] Where Email = @OldEmail)

			--Write the number of applications for the old email address into a variable for checks later on
			SELECT @FoundOldEmailApplications = COUNT (*)
			FROM [Application]
			WHERE UserId IN (SELECT Id FROM [User] Where Email = @OldEmail)

			-- Check for applications for the new email address - if any are found, do not proceed with changing the email.
			SELECT *
			FROM [Application]
			WHERE UserId IN (SELECT Id FROM [User] Where Email = @NewEmail)

			--Write the number of applications for the new email address into a variable for checks later on
			SELECT @FoundNewEmailApplications = COUNT (*)
			FROM [Application]
			WHERE UserId IN (SELECT Id FROM [User] Where Email = @NewEmail)

			--Perform checks to make sure it is safe to proceed (must be two users with the same IDM ID, only one owner and no applications linked to the new email
			IF (@FoundUsers <> '2') OR (@FoundOwners <> '1') OR (@FoundNewEmailApplications <> '0') OR (@ParametersDefined <> '1') OR (@FoundNewOwners <> '0')
				SET @SafeToProceed = 0
				ELSE SET @SafeToProceed = 1

			IF (@SafeToProceed = 1)
				PRINT 'Safe to proceed'
				ELSE PRINT 'Not safe to proceed'

			--Check of variables stored!C:\Users\nagullip\Migration\nipts-pts-sql\src\Defra.PTS.Sql\Defra.PTS.Sql.refactorlog
			PRINT 'Number of Users found with the same IDM ID as used by the original email (there should be two): ' + CAST(@FoundUsers AS NVARCHAR(100));
			PRINT 'Number of Owners found using either the old or new email addresses. There should be only one, using the old email, if this is not the case, DO NOT PROCEED: ' + CAST(@FoundOwners AS NVARCHAR(100));
			PRINT 'Number of Owners found using the new email address. There should be none, if any are found, DO NOT PROCEED: ' + CAST(@FoundNewOwners AS NVARCHAR(100));
			PRINT 'Number of applications found using the old email: ' + CAST(@FoundOldEmailApplications AS NVARCHAR(100));
			PRINT 'Number of applications found using the new email (there should be none, if there are, do not proceed): ' + CAST(@FoundNewEmailApplications AS NVARCHAR(100));
			PRINT 'Old Email User Id: ' + CAST(@OldUserId AS NVARCHAR(100))
			PRINT 'New Email User Id: ' + CAST(@NewUserId AS NVARCHAR(100))
			PRINT 'Owner Id: ' + CAST(@OwnerId AS NVARCHAR(100))
			END
-- Perform the update if IsUpdate is set to 1 and it the SafeToProceed is set to 1.
		IF (@IsUpdate = 1) AND (@SafeToProceed = 1)
		BEGIN
			PRINT 'Now Running the update process'
		
			-- Delete the user entry that has the new email as the email cannot be updated for the original user record while this exists due to the email needing to be unique in the database
			DELETE FROM [dbo].[User] WHERE Id = @NewUserId AND Email = @NewEmail

			-- Update the email in the original user entry to align with the new email
			UPDATE [dbo].[User]
			SET Email = @NewEmail
			WHERE Id = @OldUserId AND Email = @OldEmail

			-- Update the email in the Owner record
			UPDATE [dbo].[Owner]
			SET Email = @NewEmail
			WHERE Id = @OwnerId AND Email = @OldEmail
		END
		ELSE
		IF (@IsUpdate <> 1)
		PRINT 'The Update flag was not set, no changes were made'
		IF (@SafeToProceed <> 1)
		Print 'The conditions were not met, no changes were made'
END
GO


