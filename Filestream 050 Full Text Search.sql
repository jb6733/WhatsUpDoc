/* If you run the same full-text queries as with database storage
    the record counts will be the same 
   Lets turn on Statistics IO and TIME for performance comparison */

SET STATISTICS IO ON
SET STATISTICS TIME ON

/* The first query for CONTAINS 'depot' has the same logical reads between the two (64) */
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

/* We can take a peek at the proprietary filestream structure on Windows File System
   C:\DATA\WhatsUpDoc_FilestreamFS
   A guid named sub-directory is created for each table created with filestream
    A guid named sub-directory is created underneath for each filestream column
     Files underneath are named by the TSQL LSN (log sequence number) that created the file   
	DO NOT access this area in production environments
	Filestream Windows File System structure is meant for TSQL access only 
*/