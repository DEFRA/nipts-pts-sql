GO
IF EXISTS (SELECT 1 FROM [dbo].[User] WHERE Id = '9dd41028-db7d-41be-210c-08ddd316eca5' AND Email <> 'shan.jones@jttaccounts.co.uk')
BEGIN
    UPDATE [dbo].[User]
    SET Email = 'shan.jones@jttaccounts.co.uk'
    WHERE Id = '9dd41028-db7d-41be-210c-08ddd316eca5'
END
GO

IF EXISTS (SELECT 1 FROM [dbo].[User] WHERE Id = '3a09cc97-b295-434e-214d-08ddd316eca5' AND Email <> 'orjones10@gmail.com')
BEGIN
    UPDATE [dbo].[User]
    SET Email = 'orjones10@gmail.com'
    WHERE Id = '3a09cc97-b295-434e-214d-08ddd316eca5'
END
GO
