/* Create item table that uses filestream 
   A table that has FILESTREAM columns must have a nonnull 
    unique column with the ROWGUIDCOL property - this is ItemIdentifier Column 
*/
USE WhatsUpDoc_Filestream;
GO

DROP TABLE IF EXISTS [dbo].[Item]
CREATE TABLE [dbo].[Item](
   ItemID INT PRIMARY KEY CLUSTERED IDENTITY(1,1),
   ItemIdentifier UNIQUEIDENTIFIER ROWGUIDCOL NOT NULL UNIQUE, --Required column for Filestream
   [ItemNumber] VARCHAR(255),
   [ItemDescription] VARCHAR(255),
   [ImagePath] VARCHAR(255),
   [ItemImageType] VARCHAR(16),
   [ItemImage] VARBINARY(MAX) FILESTREAM NULL
)
GO

/* Rename PK Index so we can reference it as the Key Index of the Full-Text index  */
DECLARE @IndexName sysname
  , @SQLStmt NVARCHAR(128);

SET @IndexName =
(
  SELECT 'dbo.Item.' + [name] FROM sys.indexes WHERE [name] LIKE 'PK__Item__%'
);

SET @SQLStmt = 'EXEC sp_rename N''' + @IndexName + ''', N''PK_ItemID'', N''INDEX'''

EXEC sp_executesql @SQLStmt

/* Create Full Text Catalog 
    A full-text catalog is a logical container for a group of full-text indexes */
USE WhatsUpDoc_Filestream
GO
IF EXISTS ( 
 SELECT * 
   FROM sys.fulltext_catalogs 
  WHERE name = N'ItemImageFTCatalog'
)
DROP FULLTEXT CATALOG ItemImageFTCatalog
GO
CREATE FULLTEXT CATALOG ItemImageFTCatalog
GO
