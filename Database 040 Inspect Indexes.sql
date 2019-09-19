/* Inspecting indexes
   In Row Data is only 5 pages, but the LOB data with the VARBINARY MAX column is 207,693 pages
   All of those pages will have to roll through the buffer pool
*/

USE WhatsUpDoc_Database
GO
SELECT TOP 10 OBJECT_NAME(a.object_id) AS [OBJECT NAME]
  , i.name AS IndexName
  , a.* 
FROM sys.dm_db_index_physical_stats (DB_ID('WhatsUpDoc_Database'), NULL, NULL , NULL, N'Limited') a
INNER JOIN sys.indexes AS i
  ON i.[object_id] = a.[object_id]    
	  AND i.index_id = a.index_id 
ORDER BY IndexName
GO