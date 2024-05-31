GO
IF NOT EXISTS (SELECT * FROM [dbo].[Operator] Where Id = 1 AND [OperatorName] = 'Stena')
BEGIN
	INSERT [dbo].[Operator] ([Id], [OperatorName]) VALUES (1, N'Stena')
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Operator] Where Id = 2 AND [OperatorName] = 'P&O')
BEGIN
	INSERT [dbo].[Operator] ([Id], [OperatorName]) VALUES (2, N'P&O')
END
GO


GO
IF NOT EXISTS (SELECT * FROM [dbo].[Port] Where Id = 1 AND [PortName] = 'Birkenhead')
BEGIN
	INSERT [dbo].[Port] ([Id], [PortName], [PortLocation]) VALUES (1, N'Birkenhead', 'Birkenhead')
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Port] Where Id = 2 AND [PortName] = 'Belfast')
BEGIN
	INSERT [dbo].[Port] ([Id], [PortName], [PortLocation]) VALUES (2, N'Belfast', 'Belfast')
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Port] Where Id = 3 AND [PortName] = 'Cairnryan')
BEGIN
	INSERT [dbo].[Port] ([Id], [PortName], [PortLocation]) VALUES (3, N'Cairnryan', 'Cairnryan')
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Port] Where Id = 4 AND [PortName] = 'Larne')
BEGIN
	INSERT [dbo].[Port] ([Id], [PortName], [PortLocation]) VALUES (4, N'Larne', 'Larne')
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Port] Where Id = 5 AND [PortName] = 'Loch Ryan')
BEGIN
	INSERT [dbo].[Port] ([Id], [PortName], [PortLocation]) VALUES (5, N'Loch Ryan', 'Loch Ryan')
END
GO


GO
IF NOT EXISTS (SELECT * FROM [dbo].[Route] Where Id = 1 AND [RouteName] = 'Birkenhead to Belfast (Stena)')
BEGIN
	INSERT [dbo].[Route] ([Id],  [RouteName], [DeparturePort], [ArrivalPort], [Operator]) VALUES (1, N'Birkenhead to Belfast (Stena)', 1, 2, 1)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Route] Where Id = 2 AND [RouteName] = 'Cairnryan to Larne (P&O)')
BEGIN
	INSERT [dbo].[Route] ([Id],  [RouteName], [DeparturePort], [ArrivalPort], [Operator]) VALUES (2, N'Cairnryan to Larne (P&O)', 3, 4, 2)
END
GO

IF NOT EXISTS (SELECT * FROM [dbo].[Route] Where Id = 3 AND [RouteName] = 'Loch Ryan to Belfast (Stena)')
BEGIN
	INSERT [dbo].[Route] ([Id],  [RouteName], [DeparturePort], [ArrivalPort], [Operator]) VALUES (3, N'Loch Ryan to Belfast (Stena)', 5, 2, 1)
END
GO


