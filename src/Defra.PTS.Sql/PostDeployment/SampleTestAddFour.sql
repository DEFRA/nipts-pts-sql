IF NOT EXISTS (SELECT * FROM [dbo].[PasengerType] Where Id = 4 AND [Type] = 'Four')
BEGIN
	INSERT [dbo].[PasengerType] ([Id], [Type]) VALUES (4, N'Four')
END
GO