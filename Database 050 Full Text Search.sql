/* What happens if I just search for depot with CONTAINS */
USE WhatsUpDoc_Database
GO

SET STATISTICS IO ON
SELECT ImagePath AS [name] --32
FROM dbo.Item
WHERE CONTAINS(ItemImage, 'depot');
GO

/* Too many records, how about documents with both the words union AND depot */
SELECT ImagePath AS [name] --7
FROM dbo.Item
WHERE CONTAINS(ItemImage, 'union AND depot');
GO

/* Lets make sure the words are within two words of each other */
SELECT ImagePath AS [name]
FROM dbo.Item
WHERE CONTAINS(ItemImage, 'NEAR ((union, depot), 2)');
GO

/* Lets look for the exact phrase "union depot" */
SELECT ImagePath, ItemImage AS [name]
FROM dbo.Item
WHERE CONTAINS(ItemImage, '"union depot"');
GO


