/* Indexes - We see the page count for the PK cluster in row data is the same as database storage 
    One extra page is added for the required Unique non-nullable ROWGUIDCOL column
	We do NOT have the 207,693 pages of LOB data that datbase storage required
	These pages also do not have to roll through the SQL Server buffer pool
*/
USE WhatsUpDoc_Filestream
GO
SELECT TOP 10 OBJECT_NAME(a.object_id) AS [OBJECT NAME]
  , i.name AS IndexName
  , a.* 
FROM sys.dm_db_index_physical_stats (DB_ID('WhatsUpDoc_Filestream'), NULL, NULL , NULL, N'Limited') a
INNER JOIN sys.indexes AS i
  ON i.[object_id] = a.[object_id]    
	  AND i.index_id = a.index_id 
ORDER BY IndexName
GO

/* Prior index query for database storage */
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