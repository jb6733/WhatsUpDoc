USE WhatsUpDoc_Filetable
GO
SELECT TOP 10 OBJECT_NAME(a.object_id) AS [OBJECT NAME]
  , i.name AS IndexName
  , a.* 
FROM sys.dm_db_index_physical_stats (DB_ID('WhatsUpDoc_Filetable'), NULL, NULL , NULL, N'Limited') a
INNER JOIN sys.indexes AS i
  ON i.[object_id] = a.[object_id]    
	  AND i.index_id = a.index_id 
ORDER BY IndexName
GO

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