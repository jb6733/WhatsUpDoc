/* If you run the same full-text queries as the other two methods
    the record counts will be the same 
   Lets turn on Statistics IO, TIME and XML ON for performance comparison */

SET STATISTICS IO ON
SET STATISTICS TIME ON
SET STATISTICS XML ON

/* We can see that there is an extra layer of abstraction from the full-text index to file table heap */
SELECT [name] AS [name]
FROM WhatsUpDoc_FileTable.dbo.WhatsUpDoc_FileTable
WHERE CONTAINS(file_stream, 'depot');

SELECT ImagePath AS [name] 
FROM WhatsUpDoc_Filestream.dbo.Item
WHERE CONTAINS(ItemImage, 'depot');

SELECT ImagePath AS [name] 
FROM WhatsUpDoc_Database.dbo.Item
WHERE CONTAINS(ItemImage, 'depot');

/* The difference can be seen when you add the binary columns in both methods 
    This will take 10 seconds 
   Execution time more than doubles with database storage method 
    also LOB logical reads is 203,470 versus 0 in FileStream method */
SELECT ImagePath AS [name] 
  , ItemImage
FROM WhatsUpDoc_Filestream.dbo.Item
WHERE CONTAINS(ItemImage, 'depot');

SELECT ImagePath AS [name] 
  , ItemImage
FROM WhatsUpDoc_Database.dbo.Item
WHERE CONTAINS(ItemImage, 'depot');

