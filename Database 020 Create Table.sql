/* Create a table with VARBINARY max field to store unstructured data */
USE WhatsUpDoc_Database;
GO

DROP TABLE IF EXISTS [dbo].[Item];
GO

DROP TABLE IF EXISTS [dbo].[Item]
CREATE TABLE [dbo].[Item](
   ItemID INT PRIMARY KEY CLUSTERED IDENTITY(1,1),
   [ItemNumber] VARCHAR(255),
   [ItemDescription] VARCHAR(255),
   [ImagePath] VARCHAR(255),
   [ItemImageType] VARCHAR(16),
   [ItemImage] VARBINARY(MAX) NULL
) ON UserFG

/* Rename the PK Clustered index 
    We will refer to this name as the Key Column when creating the full-text index */

DECLARE @IndexName sysname
  , @SQLStmt NVARCHAR(128);

SET @IndexName =
(
  SELECT 'dbo.Item.' + [name] FROM sys.indexes WHERE [name] LIKE 'PK__Item__%'
);

SET @SQLStmt = 'EXEC sp_rename N''' + @IndexName + ''', N''PK_ItemID'', N''INDEX'''

EXEC sp_executesql @SQLStmt

/* Create FullText catalog which is a logical container of FullText Indexes */
IF EXISTS ( 
 SELECT * 
   FROM sys.fulltext_catalogs 
  WHERE name = N'ItemImageFTCatalog'
)
DROP FULLTEXT CATALOG ItemImageFTCatalog
GO
CREATE FULLTEXT CATALOG ItemImageFTCatalog
GO

/* Create FullText index in FullText catalog keyed to  */
IF EXISTS(
	SELECT * 
	  FROM sys.fulltext_indexes
      JOIN sys.tables
        ON sys.tables.object_id = sys.fulltext_indexes.object_id
	 WHERE sys.tables.name = 'items'
)
DROP FULLTEXT INDEX ON items
GO
CREATE FULLTEXT INDEX ON item (ItemImage TYPE COLUMN ItemImageType) 
	KEY INDEX PK_ItemID
	ON ItemImageFTCatalog
	WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)
GO

