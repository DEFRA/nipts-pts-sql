GO
IF NOT EXISTS (SELECT * FROM [dbo].[Organisation] Where Id = '31a7dce9-c58f-ef11-8a69-6045bdf38872' AND [Name] = 'GB Portchecks'  )
BEGIN
	INSERT [dbo].[Organisation] ([Id], [Name], [Location], [ActiveFrom], [IsActive]) VALUES ('31a7dce9-c58f-ef11-8a69-6045bdf38872', N'GB Portchecks', N'GB', GETDATE(), 1)
END
GO

GO
IF NOT EXISTS (SELECT * FROM [dbo].[Organisation] Where Id = '1b248a40-2969-ef11-a670-6045bd907478' AND [Name] = 'SPSCHECKS'  )
BEGIN
	INSERT [dbo].[Organisation] ([Id], [Name], [Location], [ActiveFrom], [IsActive]) VALUES ('1b248a40-2969-ef11-a670-6045bd907478', N'SPSCHECKS', N'NI', GETDATE(), 1)
END
GO
