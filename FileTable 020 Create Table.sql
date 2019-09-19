/* Create the FileTable */
USE WhatsUpDoc_FileTable;
GO
CREATE TABLE WhatsUpDoc_FileTable AS FILETABLE
WITH
( 
FILETABLE_DIRECTORY = 'WhatsUpDoc_FileTableFiles', --this will designate the accessible share
FILETABLE_COLLATE_FILENAME = DATABASE_DEFAULT --collation for name column in the file table
);
GO

/* Display the database level File Table share 
   Below is the table level File Table share that SQL created above 
*/
USE WhatsUpDoc_FileTable
GO  
DECLARE @root nvarchar(100);  
DECLARE @fullpath nvarchar(1000);  
  
SELECT @root = FileTableRootPath();  
SELECT @fullpath = @root + file_stream.GetFileNamespacePath()  
    FROM WhatsUpDoc_FileTable;  
  
SELECT FileTableRootPath();  
PRINT @fullpath;  
GO  

/* Open Powershell ISE and run ROBOCOPY command that moves 
   This is the same 192 documents as the other databases
*/
ROBOCOPY "C:\tidbit\MenOfGritAndGreatness_Holzworth_W_F" "\\W10ljbruno\foundation\WhatsUpDoc_FileTable\WhatsUpDoc_FileTableFiles" *.*

/* This is what the File Table looks like
    like before we comment out the binary column since its an unnecessary display 
   Contains a lot of the windows file system attributes
   can define indexes, constraints and triggers
   however the columns and system defined constrains cannot be altered or dropped  
*/
SELECT [stream_id]
--  , [file_stream]
  , [name]
  , [path_locator]
  , [parent_path_locator]
  , [file_type]
  , [cached_file_size]
  , [creation_time]
  , [last_write_time]
  , [last_access_time]
  , [is_directory]
  , [is_offline]
  , [is_hidden]
  , [is_readonly]
  , [is_archive]
  , [is_system]
  , [is_temporary]
FROM WhatsUpDoc_FileTable;

/* Create Full Text Catalog */
IF EXISTS ( 
 SELECT * 
   FROM sys.fulltext_catalogs 
  WHERE name = N'WhatsUpDoc_FileTableFTCatalog'
)
DROP FULLTEXT CATALOG WhatsUpDoc_FileTableFTCatalog
GO
CREATE FULLTEXT CATALOG WhatsUpDoc_FileTableFTCatalog
GO

/* Create Full Text Index - similar to filestream method 
    Make sure you are out of the files and sub-directory 
	This might taka a couple of minutes for meta data and index to populate 
    Right Click Storage->Full Text Catalogs->WhatsUpDoc_FileTableFTCatalog->Rebuild	
*/
    
IF EXISTS(
	SELECT * 
	  FROM sys.fulltext_indexes
      JOIN sys.tables
        ON sys.tables.object_id = sys.fulltext_indexes.object_id
	 WHERE sys.tables.name = 'WhatsUpDoc_FileTable'
)
DROP FULLTEXT INDEX ON WhatsUpDoc_FileTable
GO

DECLARE @IndexName sysname
  , @SQLStmt NVARCHAR(4000);

SET @IndexName = (SELECT TOP 1 [name] FROM sys.indexes WHERE [name] LIKE 'UQ__WhatsUpD__9D%' ORDER BY [name])
SET @SQLStmt = 'CREATE FULLTEXT INDEX ON WhatsUpDoc_FileTable (file_stream TYPE COLUMN file_type) 
	KEY INDEX ' + @IndexName + '
	ON WhatsUpDoc_FileTableFTCatalog
	WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)'
--PRINT @SQLStmt
EXEC sp_executesql @SQLStmt;

/* If this hasn't populated yet look at FT Search execution plans */
SELECT *
FROM sys.dm_fts_index_keywords(DB_ID('WhatsUpDoc_FileTable'), OBJECT_ID('WhatsUpDoc_FileTable'))

/* This TSQL tells me what terms belong to which document */
DROP TABLE IF EXISTS #MyDocIDMapping 
CREATE TABLE #MyDocIDMapping 
(
  MyDocID INT
  , MyKey UNIQUEIDENTIFIER
)
DECLARE @tblID INT;
SET @tblID = (SELECT OBJECT_ID('WhatsUpDoc_FileTable'))
INSERT INTO #MyDocIDMapping (MyDocID, MyKey)
EXEC sys.sp_fulltext_keymappings @tblID

SELECT ft.[name] DocumentName
  , w.display_term
FROM sys.dm_fts_index_keywords_by_document(DB_ID('WhatsUpDoc_FileTable'), OBJECT_ID('WhatsUpDoc_FileTable')) w
INNER JOIN #MyDocIDMapping d
  ON w.document_id = d.MyDocID
INNER JOIN dbo.WhatsUpDoc_FileTable ft
  ON d.MyKey = ft.stream_id
ORDER BY ft.[name]
  , w.display_term

