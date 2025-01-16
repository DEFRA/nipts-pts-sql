IF NOT EXISTS (SELECT * FROM [dbo].[PasengerType] Where Id = 5 AND [Type] = 'Five')
BEGIN
	INSERT [dbo].[PasengerType] ([Id], [Type]) VALUES (5, N'Five')
END
GO