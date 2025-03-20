-- =============================================
-- Description:	
     -- Gets all GB Check records that have a corresponding NI Check Done
	 --Gets all GB Check records that donot have a corresponding NI Check
	 --Gets all Flighst/NI Check records that donot have a GB Check(passengers who are directed to go for NI Check Due to Short of Time at GB Side)

	--ExtractIntervalInHours
	--24 Daily
	--48 Two days(Ones in two days)
	--168 Seven Days(Weekly)
	--63 Random

-- =============================================
CREATE PROCEDURE [dbo].[CheckReportData] 
	-- Add the parameters for the stored procedure here
	@ExtractIntervalInHours INT = 24
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	-- Enforce non-nullability
    IF @ExtractIntervalInHours IS NULL
    BEGIN
        RAISERROR('ExtractIntervalInHours cannot be NULL.', 16, 1);
        RETURN;
    END


	DECLARE @CurrentDateTime DATETIME = GETDATE();

	DECLARE @Duration INT = -48;
	DECLARE @ToDate DATE;
	DECLARE @FromDate DATE;
	DECLARE @CutOffTime TIME(7);

	DECLARE @Pass  VARCHAR(7) = 'Pass';
	DECLARE @Fail  VARCHAR(20) = 'Fail/Refer to SPS'
	DECLARE @Allowed  VARCHAR(20) = 'Allowed to travel'
	DECLARE @NotAllowed  VARCHAR(25) ='Not allowed to travel'

	SET @ToDate = CAST(DATEADD(HOUR, @Duration, @CurrentDateTime) AS DATE);
	SET @FromDate = CAST(DATEADD(HOUR, @Duration - @ExtractIntervalInHours, @CurrentDateTime) AS DATE);
	SET @CutOffTime = CAST(DATEADD(MINUTE, DATEDIFF(MINUTE, 0, DATEADD(HOUR, @Duration, @CurrentDateTime)), 0) AS TIME(7));

	--Gets all GB Check records that have a corresponding NI Check Done
	SELECT
		   (SELECT [ReferenceNumber] FROM [dbo].[Application] WHERE Id = chsOuter.[ApplicationId]) AS [Application Number]
		  ,(SELECT [DocumentReferenceNumber] FROM [dbo].[TravelDocument] WHERE [Id] = chsOuter.[TravelDocumentId]) AS [PTD number]
		  ,(SELECT [Status] FROM [dbo].[Application] WHERE Id = chsOuter.[ApplicationId]) AS [Document Status at time of extract]
		  ,CASE [CheckOutcome]
				WHEN 1 THEN @Pass
				WHEN 0 THEN @Fail
				ELSE ''
			END AS  [GB Check Status]
		   ,CASE (SELECT [CheckOutcome] FROM [dbo].[CheckSummary] WHERE Id = chsOuter.LinkedCheckId AND [GBCheck] = 0)
				WHEN 1 THEN @Pass
				WHEN 0 THEN @Fail
				ELSE ''
			END AS  [NI Check Status]
		  ,CASE (SELECT [SPSOutcome] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId)
			WHEN 1 THEN @Allowed
			WHEN 0 THEN @NotAllowed
			ELSE ''
		   END AS [SPSOutcome]
		  ,ISNULL((SELECT [RouteName] FROM [dbo].[Route] WHERE [Id] = [RouteId]), '') AS [Ferry Route]
		  ,ISNULL([FlightNo], '') AS [Flight]
		  ,ISNULL(CAST((SELECT [PassengerTypeId] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '') AS [Method of Travel]
		  ,[Date] AS [Travel Date]
		  ,[ScheduledSailingTime] AS [Sailing Time]

		  ,ISNULL(CAST((SELECT [MCNotMatch] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '') AS [GB - MC Does not match]
		  ,ISNULL(CAST((SELECT [MCNotMatch] FROM [dbo].[CheckOutcome] WHERE Id = (SELECT [CheckOutcomeId] FROM [dbo].[CheckSummary] WHERE Id = chsOuter.LinkedCheckId AND [GBCheck] = 0)) AS VARCHAR), '') AS [NI - MC Does not match]

		  ,ISNULL(CAST((SELECT [MCNotFound] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '') AS [GB - Cannot find microhip]
		  ,ISNULL(CAST((SELECT [MCNotFound] FROM [dbo].[CheckOutcome] WHERE Id = (SELECT [CheckOutcomeId] FROM [dbo].[CheckSummary] WHERE Id = chsOuter.LinkedCheckId AND [GBCheck] = 0)) AS VARCHAR), '') AS [NI - Cannot find microhip]

		  ,ISNULL(CAST((SELECT [VCNotMatchPTD] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB - Pet Doesn’t match PTD]
		  ,ISNULL(CAST((SELECT [VCNotMatchPTD] FROM [dbo].[CheckOutcome] WHERE Id = (SELECT [CheckOutcomeId] FROM [dbo].[CheckSummary] WHERE Id = chsOuter.LinkedCheckId AND [GBCheck] = 0)) AS VARCHAR), '') AS [NI - Pet Doesn’t match PTD]

		  ,ISNULL(CAST((SELECT [OIFailPotentialCommercial] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB - Potential Commercial]
		  ,ISNULL(CAST((SELECT [OIFailPotentialCommercial] FROM [dbo].[CheckOutcome] WHERE Id = (SELECT [CheckOutcomeId] FROM [dbo].[CheckSummary] WHERE Id = chsOuter.LinkedCheckId AND [GBCheck] = 0)) AS VARCHAR), '') AS [NI - Potential Commercial]
	  
		  ,ISNULL(CAST((SELECT [OIFailAuthTravellerNoConfirmation] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB - Authorised traveller no confirmation]
		  ,ISNULL(CAST((SELECT [OIFailAuthTravellerNoConfirmation] FROM [dbo].[CheckOutcome] WHERE Id = (SELECT [CheckOutcomeId] FROM [dbo].[CheckSummary] WHERE Id = chsOuter.LinkedCheckId AND [GBCheck] = 0)) AS VARCHAR), '') AS [NI - Authorised traveller no confirmation]

		  ,ISNULL(CAST((SELECT [OIFailOther] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB - Other Reason]
		  ,ISNULL(CAST((SELECT [OIFailOther] FROM [dbo].[CheckOutcome] WHERE Id = (SELECT [CheckOutcomeId] FROM [dbo].[CheckSummary] WHERE Id = chsOuter.LinkedCheckId AND [GBCheck] = 0)) AS VARCHAR), '') AS [NI - Other Reason]

	FROM 
			[dbo].[CheckSummary] AS chsOuter
	WHERE
			[GBCheck] = 1 
	AND		[LinkedCheckId] IS NOT NULL
	AND     [Superseded] IS NULL
	AND		([Date] <= @ToDate)
	AND		([Date] >= @FromDate)
	AND		(
				([Date] > @FromDate) -- Ensure all times are included for future dates
				OR ([Date] = @FromDate AND [ScheduledSailingTime] >= @CutOffTime) -- Ensure times are included on the start date
			)
	AND		(
				([Date] < @ToDate) -- Ensure all times are included for past dates
				OR ([Date] = @ToDate AND [ScheduledSailingTime] <= @CutOffTime) -- Ensure times are included on the end date
			)


	UNION

	--Gets all GB Check records that donot have a corresponding NI Check
	SELECT
		   (SELECT [ReferenceNumber] FROM [dbo].[Application] WHERE Id = chsOuter.[ApplicationId]) AS [Application Number]
		  ,(SELECT [DocumentReferenceNumber] FROM [dbo].[TravelDocument] WHERE [Id] = chsOuter.[TravelDocumentId]) AS [PTD number]
		  ,(SELECT [Status] FROM [dbo].[Application] WHERE Id = chsOuter.[ApplicationId]) AS [Document Status at time of extract]
		  ,CASE [CheckOutcome]
			WHEN 1 THEN @Pass
			WHEN 0 THEN @Fail
			ELSE ''
		   END AS  [GB Check Status]
		  ,'' AS [NI Check Status]
		  ,CASE (SELECT [SPSOutcome] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) 
			WHEN 1 THEN @Allowed
			WHEN 0 THEN @NotAllowed
			ELSE ''
		   END AS [SPSOutcome]
		  ,ISNULL((SELECT [RouteName] FROM [dbo].[Route] WHERE [Id] = [RouteId]), '') AS [Ferry Route]
		  ,ISNULL([FlightNo], '') AS [Flight]
		  ,ISNULL(CAST((SELECT [PassengerTypeId] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '') AS [Method of Travel]
		  ,[Date] AS [Travel Date]
		  ,[ScheduledSailingTime] AS [Sailing Time]

		  ,ISNULL(CAST((SELECT [MCNotMatch] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB - MC Does not match]
		  ,'' AS [NI - MC Does not match]

		  ,ISNULL(CAST((SELECT [MCNotFound] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB - Cannot find microhip]
		  ,'' AS [NI - Cannot find microhip]

		  ,ISNULL(CAST((SELECT [VCNotMatchPTD] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB - Pet Doesn’t match PTD]
		  ,'' AS [NI - Pet Doesn’t match PTD]

		  ,ISNULL(CAST((SELECT [OIFailPotentialCommercial] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB - Potential Commercial]
		  ,'' AS [NI - Potential Commercial]
	  
		  ,ISNULL(CAST((SELECT [OIFailAuthTravellerNoConfirmation] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB - Authorised traveller no confirmation]
		  ,'' AS [NI - Authorised traveller no confirmation]

		  ,ISNULL(CAST((SELECT [OIFailOther] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB - Other Reason]
		  ,'' AS [NI - Other Reason]
	FROM 
			[dbo].[CheckSummary] AS chsOuter
	WHERE
			[GBCheck] = 1
	AND		[LinkedCheckId] IS NULL
	AND     [Superseded] IS NULL
	AND		([Date] <= @ToDate)
	AND		([Date] >= @FromDate)
	AND		(
				([Date] > @FromDate) -- Ensure all times are included for future dates
				OR ([Date] = @FromDate AND [ScheduledSailingTime] >= @CutOffTime) -- Ensure times are included on the start date
			)
	AND		(
				([Date] < @ToDate) -- Ensure all times are included for past dates
				OR ([Date] = @ToDate AND [ScheduledSailingTime] <= @CutOffTime) -- Ensure times are included on the end date
			)

	UNION

		--Gets all Flighst/NI Check records that donot have a GB Check(passengers who are directed to go for NI Check Due to Short of Time at GB Side)
		SELECT
			   (SELECT [ReferenceNumber] FROM [dbo].[Application] WHERE Id = chsOuter.[ApplicationId]) AS [Application Number]
			  ,(SELECT [DocumentReferenceNumber] FROM [dbo].[TravelDocument] WHERE [Id] = chsOuter.[TravelDocumentId]) AS [PTD number]
			  ,(SELECT [Status] FROM [dbo].[Application] WHERE Id = chsOuter.[ApplicationId]) AS [Document Status at time of extract]
			  ,'' AS [GB Check Status]
			  ,CASE [CheckOutcome]
				WHEN 1 THEN @Pass
				WHEN 0 THEN @Fail
				ELSE ''
				END AS  [NI Check Status]
			  ,CASE (SELECT [SPSOutcome] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) 
				WHEN 1 THEN @Allowed
				WHEN 0 THEN @NotAllowed
				ELSE ''
			   END AS [SPSOutcome]
			  ,ISNULL((SELECT [RouteName] FROM [dbo].[Route] WHERE [Id] = [RouteId]), '') AS [Ferry Route]
			  ,ISNULL([FlightNo], '') AS [Flight]
			  ,ISNULL(CAST((SELECT [PassengerTypeId] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '') AS [Method of Travel]
			  ,[Date] AS [Travel Date]
			  ,[ScheduledSailingTime] AS [Sailing Time]

			  ,'' AS [GB - MC Does not match]
			  ,ISNULL(CAST((SELECT [MCNotMatch] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [NI - MC Does not match]

			  ,'' AS [GB - Cannot find microhip]
			  ,ISNULL(CAST((SELECT [MCNotFound] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [NI - Cannot find microhip]

			  ,'' AS [GB - Pet Doesn’t match PTD]
			  ,ISNULL(CAST((SELECT [VCNotMatchPTD] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [NI - Pet Doesn’t match PTD]

			  ,'' AS [GB - Potential Commercial]
			  ,ISNULL(CAST((SELECT [OIFailPotentialCommercial] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [NI - Potential Commercial]
	  
			  ,'' AS [GB - Authorised traveller no confirmation]
			  ,ISNULL(CAST((SELECT [OIFailAuthTravellerNoConfirmation] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [NI - Authorised traveller no confirmation]

			  ,'' AS [GB - Other Reason]
			  ,ISNULL(CAST((SELECT [OIFailOther] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [NI - Other Reason]
		FROM 
				[dbo].[CheckSummary] AS chsOuter
		WHERE
				[GBCheck] = 0
		AND		[LinkedCheckId] IS NULL
		AND     [Superseded] IS NULL
		AND		([Date] <= @ToDate)
		AND		([Date] >= @FromDate)
		AND		(
					([Date] > @FromDate) -- Ensure all times are included for future dates
					OR ([Date] = @FromDate AND [ScheduledSailingTime] >= @CutOffTime) -- Ensure times are included on the start date
				)
		AND		(
					([Date] < @ToDate) -- Ensure all times are included for past dates
					OR ([Date] = @ToDate AND [ScheduledSailingTime] <= @CutOffTime) -- Ensure times are included on the end date
				)

END
GO



