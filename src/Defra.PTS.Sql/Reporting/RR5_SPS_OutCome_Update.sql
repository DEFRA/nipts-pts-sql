	DECLARE @ExtractIntervalInHours INT = 24



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

	SELECT
		   (SELECT [ReferenceNumber] FROM [dbo].[Application] WHERE Id = chsOuter.[ApplicationId]) AS [Application_Number]
		  ,(SELECT [DocumentReferenceNumber] FROM [dbo].[TravelDocument] WHERE [Id] = chsOuter.[TravelDocumentId]) AS [PTD_number]
		  ,(SELECT [Status] FROM [dbo].[Application] WHERE Id = chsOuter.[ApplicationId]) AS [Document_Status_at_time_of_extract]
		  ,CASE [CheckOutcome]
				WHEN 1 THEN @Pass
				WHEN 0 THEN @Fail
				ELSE ''
			END AS  [GB_Check_Status]
		   ,CASE (SELECT [CheckOutcome] FROM [dbo].[CheckSummary] WHERE Id = chsOuter.LinkedCheckId AND [GBCheck] = 0)
				WHEN 1 THEN @Pass
				WHEN 0 THEN @Fail
				ELSE ''
			END AS  [NI_Check_Status]
		  ,CASE (SELECT [SPSOutcome] FROM [dbo].[CheckOutcome] WHERE Id = (SELECT [CheckOutcomeId] FROM [dbo].[CheckSummary] WHERE Id = chsOuter.LinkedCheckId AND [GBCheck] = 0))
			WHEN 1 THEN @Allowed
			WHEN 0 THEN @NotAllowed
			ELSE ''
		   END AS [SPSOutcome]
		  ,ISNULL((SELECT [RouteName] FROM [dbo].[Route] WHERE [Id] = [RouteId]), '') AS [Ferry_Route]
		  ,ISNULL([FlightNo], '') AS [Flight]
		  ,ISNULL((SELECT [Type] FROM [dbo].[PasengerType] WHERE Id = (SELECT [PassengerTypeId] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId)), '') AS [Method_of_Travel]
		  ,[Date] AS [Travel_Date]
		  ,[ScheduledSailingTime] AS [Sailing_Time]

		  ,ISNULL(CAST((SELECT [MCNotMatch] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '') AS [GB_MC_Does_not_match]
		  ,ISNULL(CAST((SELECT [MCNotMatch] FROM [dbo].[CheckOutcome] WHERE Id = (SELECT [CheckOutcomeId] FROM [dbo].[CheckSummary] WHERE Id = chsOuter.LinkedCheckId AND [GBCheck] = 0)) AS VARCHAR), '') AS [NI_MC_Does_not_match]

		  ,ISNULL(CAST((SELECT [MCNotFound] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '') AS [GB_Cannot_find_microhip]
		  ,ISNULL(CAST((SELECT [MCNotFound] FROM [dbo].[CheckOutcome] WHERE Id = (SELECT [CheckOutcomeId] FROM [dbo].[CheckSummary] WHERE Id = chsOuter.LinkedCheckId AND [GBCheck] = 0)) AS VARCHAR), '') AS [NI_Cannot_find_microhip]

		  ,ISNULL(CAST((SELECT [VCNotMatchPTD] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB_Pet_Does_not_match_PTD]
		  ,ISNULL(CAST((SELECT [VCNotMatchPTD] FROM [dbo].[CheckOutcome] WHERE Id = (SELECT [CheckOutcomeId] FROM [dbo].[CheckSummary] WHERE Id = chsOuter.LinkedCheckId AND [GBCheck] = 0)) AS VARCHAR), '') AS [NI_Pet_Does_not_match_PTD]

		  ,ISNULL(CAST((SELECT [OIFailPotentialCommercial] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB_Potential_Commercial]
		  ,ISNULL(CAST((SELECT [OIFailPotentialCommercial] FROM [dbo].[CheckOutcome] WHERE Id = (SELECT [CheckOutcomeId] FROM [dbo].[CheckSummary] WHERE Id = chsOuter.LinkedCheckId AND [GBCheck] = 0)) AS VARCHAR), '') AS [NI_Potential_Commercial]
	  
		  ,ISNULL(CAST((SELECT [OIFailAuthTravellerNoConfirmation] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB_Authorised_traveller_no_confirmation]
		  ,ISNULL(CAST((SELECT [OIFailAuthTravellerNoConfirmation] FROM [dbo].[CheckOutcome] WHERE Id = (SELECT [CheckOutcomeId] FROM [dbo].[CheckSummary] WHERE Id = chsOuter.LinkedCheckId AND [GBCheck] = 0)) AS VARCHAR), '') AS [NI_Authorised_traveller_no_confirmation]

		  ,ISNULL(CAST((SELECT [OIRefusedToSignDeclaration] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS GB_AP_Refused_to_sign
		  ,ISNULL(CAST((SELECT [OIRefusedToSignDeclaration] FROM [dbo].[CheckOutcome] WHERE Id = (SELECT [CheckOutcomeId] FROM [dbo].[CheckSummary] WHERE Id = chsOuter.LinkedCheckId AND [GBCheck] = 0)) AS VARCHAR), '') AS NI_AP_Refused_to_sign

		  ,ISNULL(CAST((SELECT [OIFailOther] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB_Other_Reason]
		  ,ISNULL(CAST((SELECT [OIFailOther] FROM [dbo].[CheckOutcome] WHERE Id = (SELECT [CheckOutcomeId] FROM [dbo].[CheckSummary] WHERE Id = chsOuter.LinkedCheckId AND [GBCheck] = 0)) AS VARCHAR), '') AS [NI_Other_Reason]

	FROM 
			[dbo].[CheckSummary] AS chsOuter
	WHERE
			[GBCheck] = 1 
	AND		[LinkedCheckId] IS NOT NULL
	AND     [Superseded] IS NULL
	AND		([Date] <= @ToDate)
	AND		([Date] >= @FromDate)
	AND		(
				([Date] > @FromDate)
				OR ([Date] = @FromDate AND [ScheduledSailingTime] >= @CutOffTime)
			)
	AND		(
				([Date] < @ToDate)
				OR ([Date] = @ToDate AND [ScheduledSailingTime] <= @CutOffTime)
			)


	UNION

	SELECT
		   (SELECT [ReferenceNumber] FROM [dbo].[Application] WHERE Id = chsOuter.[ApplicationId]) AS [Application_Number]
		  ,(SELECT [DocumentReferenceNumber] FROM [dbo].[TravelDocument] WHERE [Id] = chsOuter.[TravelDocumentId]) AS [PTD_number]
		  ,(SELECT [Status] FROM [dbo].[Application] WHERE Id = chsOuter.[ApplicationId]) AS [Document_Status_at_time_of_extract]
		  ,CASE [CheckOutcome]
			WHEN 1 THEN @Pass
			WHEN 0 THEN @Fail
			ELSE ''
		   END AS  [GB_Check_Status]
		  ,'' AS [NI_Check_Status]
		  ,CASE (SELECT [SPSOutcome] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) 
			WHEN 1 THEN @Allowed
			WHEN 0 THEN @NotAllowed
			ELSE ''
		   END AS [SPSOutcome]
		  ,ISNULL((SELECT [RouteName] FROM [dbo].[Route] WHERE [Id] = [RouteId]), '') AS [Ferry_Route]
		  ,ISNULL([FlightNo], '') AS [Flight]
		  ,ISNULL((SELECT [Type] FROM [dbo].[PasengerType] WHERE Id = (SELECT [PassengerTypeId] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId)), '') AS [Method_of_Travel]
		  ,[Date] AS [Travel_Date]
		  ,[ScheduledSailingTime] AS [Sailing_Time]

		  ,ISNULL(CAST((SELECT [MCNotMatch] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB_MC_Does_not_match]
		  ,'' AS [NI_MC_Does_not_match]

		  ,ISNULL(CAST((SELECT [MCNotFound] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB_Cannot_find_microhip]
		  ,'' AS [NI_Cannot_find_microhip]

		  ,ISNULL(CAST((SELECT [VCNotMatchPTD] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB_Pet_Does_not_match_PTD]
		  ,'' AS [NI_Pet_Does_not_match_PTD]

		  ,ISNULL(CAST((SELECT [OIFailPotentialCommercial] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB_Potential_Commercial]
		  ,'' AS [NI_Potential_Commercial]
	  
		  ,ISNULL(CAST((SELECT [OIFailAuthTravellerNoConfirmation] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB_Authorised_traveller_no_confirmation]
		  ,'' AS [NI_Authorised_traveller_no_confirmation]

		  ,ISNULL(CAST((SELECT [OIRefusedToSignDeclaration] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS GB_AP_Refused_to_sign
		  ,'' AS NI_AP_Refused_to_sign

		  ,ISNULL(CAST((SELECT [OIFailOther] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [GB_Other_Reason]
		  ,'' AS [NI_Other_Reason]
	FROM 
			[dbo].[CheckSummary] AS chsOuter
	WHERE
			[GBCheck] = 1
	AND		[LinkedCheckId] IS NULL
	AND     [Superseded] IS NULL
	AND		([Date] <= @ToDate)
	AND		([Date] >= @FromDate)
	AND		(
				([Date] > @FromDate) 
				OR ([Date] = @FromDate AND [ScheduledSailingTime] >= @CutOffTime) 
			)
	AND		(
				([Date] < @ToDate) 
				OR ([Date] = @ToDate AND [ScheduledSailingTime] <= @CutOffTime) 
			)

	UNION

		SELECT
			   (SELECT [ReferenceNumber] FROM [dbo].[Application] WHERE Id = chsOuter.[ApplicationId]) AS [Application_Number]
			  ,(SELECT [DocumentReferenceNumber] FROM [dbo].[TravelDocument] WHERE [Id] = chsOuter.[TravelDocumentId]) AS [PTD_number]
			  ,(SELECT [Status] FROM [dbo].[Application] WHERE Id = chsOuter.[ApplicationId]) AS [Document_Status_at_time_of_extract]
			  ,'' AS [GB_Check_Status]
			  ,CASE [CheckOutcome]
				WHEN 1 THEN @Pass
				WHEN 0 THEN @Fail
				ELSE ''
				END AS  [NI_Check_Status]
			  ,CASE (SELECT [SPSOutcome] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) 
				WHEN 1 THEN @Allowed
				WHEN 0 THEN @NotAllowed
				ELSE ''
			   END AS [SPSOutcome]
			  ,ISNULL((SELECT [RouteName] FROM [dbo].[Route] WHERE [Id] = [RouteId]), '') AS [Ferry_Route]
			  ,ISNULL([FlightNo], '') AS [Flight]
			  ,ISNULL((SELECT [Type] FROM [dbo].[PasengerType] WHERE Id = (SELECT [PassengerTypeId] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId)), '') AS [Method_of_Travel]
			  ,[Date] AS [Travel_Date]
			  ,[ScheduledSailingTime] AS [Sailing_Time]

			  ,'' AS [GB_MC_Does_not_match]
			  ,ISNULL(CAST((SELECT [MCNotMatch] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [NI_MC_Does_not_match]

			  ,'' AS [GB_Cannot_find_microhip]
			  ,ISNULL(CAST((SELECT [MCNotFound] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [NI_Cannot_find_microhip]

			  ,'' AS [GB_Pet_Does_not_match_PTD]
			  ,ISNULL(CAST((SELECT [VCNotMatchPTD] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [NI_Pet_Does_not_match_PTD]

			  ,'' AS [GB_Potential_Commercial]
			  ,ISNULL(CAST((SELECT [OIFailPotentialCommercial] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [NI_Potential_Commercial]
	  
			  ,'' AS [GB_Authorised_traveller_no_confirmation]
			  ,ISNULL(CAST((SELECT [OIFailAuthTravellerNoConfirmation] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [NI_Authorised_traveller_no_confirmation]

			  ,'' AS GB_AP_Refused_to_sign
			  ,ISNULL(CAST((SELECT [OIRefusedToSignDeclaration] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS NI_AP_Refused_to_sign

			  ,'' AS [GB_Other_Reason]
			  ,ISNULL(CAST((SELECT [OIFailOther] FROM [dbo].[CheckOutcome] WHERE Id = chsOuter.CheckOutcomeId) AS VARCHAR), '')  AS [NI_Other_Reason]
		FROM 
				[dbo].[CheckSummary] AS chsOuter
		WHERE
				[GBCheck] = 0
		AND		[LinkedCheckId] IS NULL
		AND     [Superseded] IS NULL
		AND		([Date] <= @ToDate)
		AND		([Date] >= @FromDate)
		AND		(
					([Date] > @FromDate) 
					OR ([Date] = @FromDate AND [ScheduledSailingTime] >= @CutOffTime)
				)
		AND		(
					([Date] < @ToDate) 
					OR ([Date] = @ToDate AND [ScheduledSailingTime] <= @CutOffTime) 
				)



