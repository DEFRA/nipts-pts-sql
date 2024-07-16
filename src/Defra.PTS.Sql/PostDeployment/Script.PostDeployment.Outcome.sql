GO
IF NOT EXISTS (SELECT 1 FROM [dbo].[Outcome] WHERE [Id] = 1)
BEGIN
	INSERT INTO [dbo].[Outcome]([Id], [Type]) VALUES (1 , 'Pass')
END

GO

IF NOT EXISTS (SELECT 1 FROM [dbo].[Outcome] WHERE [Id] = 2)
BEGIN
	INSERT INTO [dbo].[Outcome]([Id], [Type]) VALUES (2 , 'Fail')
END

GO