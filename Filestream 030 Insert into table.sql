/* These are the same exact insert statements as the Database storage method
   TSQL is the only method of interaction */
USE WhatsUpDoc_Filestream
GO

TRUNCATE TABLE dbo.item

DECLARE @Path VARCHAR(128) = 'C:\tidbit\MenOfGritAndGreatness\'
  , @FullName VARCHAR(256)
  , @SQLStmt NVARCHAR(512)

DROP TABLE IF EXISTS #Documents
CREATE TABLE #Documents
(
  DocumentName VARCHAR(128)
)

INSERT INTO #Documents(DocumentName)
VALUES
('0070.tif')
, ('0080.tif')
, ('0090.tif')
, ('0100.tif')
, ('0110.tif')
, ('0120.tif')
, ('0130.tif')
, ('0140.tif')
, ('0160.tif')
, ('0170.tif')
, ('Image (100).tif')
, ('Image (101).tif')
, ('Image (102).tif')
, ('Image (103).tif')
, ('Image (104).tif')
, ('Image (105).tif')
, ('Image (106).tif')
, ('Image (107).tif')
, ('Image (108).tif')
, ('Image (109).tif')
, ('Image (11).tif')
, ('Image (110).tif')
, ('Image (111).tif')
, ('Image (112).tif')
, ('Image (113).tif')
, ('Image (114).tif')
, ('Image (115).tif')
, ('Image (116).tif')
, ('Image (117).tif')
, ('Image (118).tif')
, ('Image (119).tif')
, ('Image (12).tif')
, ('Image (120).tif')
, ('Image (121).tif')
, ('Image (122).tif')
, ('Image (123).tif')
, ('Image (124).tif')
, ('Image (125).tif')
, ('Image (126).tif')
, ('Image (127).tif')
, ('Image (128).tif')
, ('Image (129).tif')
, ('Image (13).tif')
, ('Image (130).tif')
, ('Image (131).tif')
, ('Image (132).tif')
, ('Image (133).tif')
, ('Image (134).tif')
, ('Image (135).tif')
, ('Image (136).tif')
, ('Image (137).tif')
, ('Image (138).tif')
, ('Image (139).tif')
, ('Image (14).tif')
, ('Image (140).tif')
, ('Image (141).tif')
, ('Image (142).tif')
, ('Image (143).tif')
, ('Image (144).tif')
, ('Image (145).tif')
, ('Image (146).tif')
, ('Image (147).tif')
, ('Image (148).tif')
, ('Image (149).tif')
, ('Image (15).tif')
, ('Image (150).tif')
, ('Image (151).tif')
, ('Image (152).tif')
, ('Image (153).tif')
, ('Image (154).tif')
, ('Image (155).tif')
, ('Image (156).tif')
, ('Image (157).tif')
, ('Image (158).tif')
, ('Image (159).tif')
, ('Image (16).tif')
, ('Image (160).tif')
, ('Image (161).tif')
, ('Image (162).tif')
, ('Image (163).tif')
, ('Image (164).tif')
, ('Image (165).tif')
, ('Image (166).tif')
, ('Image (167).tif')
, ('Image (168).tif')
, ('Image (169).tif')
, ('Image (17).tif')
, ('Image (170).tif')
, ('Image (171).tif')
, ('Image (172).tif')
, ('Image (173).tif')
, ('Image (174).tif')
, ('Image (175).tif')
, ('Image (176).tif')
, ('Image (177).tif')
, ('Image (178).tif')
, ('Image (179).tif')
, ('Image (18).tif')
, ('Image (180).tif')
, ('Image (181).tif')
, ('Image (182).tif')
, ('Image (183).tif')
, ('Image (184).tif')
, ('Image (185).tif')
, ('Image (186).tif')
, ('Image (187).tif')
, ('Image (188).tif')
, ('Image (189).tif')
, ('Image (19).tif')
, ('Image (190).tif')
, ('Image (191).tif')
, ('Image (192).tif')
, ('Image (20).tif')
, ('Image (21).tif')
, ('Image (22).tif')
, ('Image (23).tif')
, ('Image (24).tif')
, ('Image (25).tif')
, ('Image (26).tif')
, ('Image (27).tif')
, ('Image (28).tif')
, ('Image (29).tif')
, ('Image (30).tif')
, ('Image (31).tif')
, ('Image (32).tif')
, ('Image (33).tif')
, ('Image (34).tif')
, ('Image (35).tif')
, ('Image (36).tif')
, ('Image (37).tif')
, ('Image (38).tif')
, ('Image (39).tif')
, ('Image (40).tif')
, ('Image (41).tif')
, ('Image (42).tif')
, ('Image (43).tif')
, ('Image (44).tif')
, ('Image (45).tif')
, ('Image (46).tif')
, ('Image (47).tif')
, ('Image (48).tif')
, ('Image (49).tif')
, ('Image (50).tif')
, ('Image (51).tif')
, ('Image (52).tif')
, ('Image (53).tif')
, ('Image (54).tif')
, ('Image (55).tif')
, ('Image (56).tif')
, ('Image (57).tif')
, ('Image (58).tif')
, ('Image (59).tif')
, ('Image (60).tif')
, ('Image (61).tif')
, ('Image (62).tif')
, ('Image (63).tif')
, ('Image (64).tif')
, ('Image (65).tif')
, ('Image (66).tif')
, ('Image (67).tif')
, ('Image (68).tif')
, ('Image (69).tif')
, ('Image (70).tif')
, ('Image (71).tif')
, ('Image (72).tif')
, ('Image (73).tif')
, ('Image (74).tif')
, ('Image (75).tif')
, ('Image (76).tif')
, ('Image (77).tif')
, ('Image (78).tif')
, ('Image (79).tif')
, ('Image (80).tif')
, ('Image (81).tif')
, ('Image (82).tif')
, ('Image (83).tif')
, ('Image (84).tif')
, ('Image (85).tif')
, ('Image (86).tif')
, ('Image (87).tif')
, ('Image (88).tif')
, ('Image (89).tif')
, ('Image (90).tif')
, ('Image (91).tif')
, ('Image (92).tif')
, ('Image (93).tif')
, ('Image (94).tif')
, ('Image (95).tif')
, ('Image (96).tif')
, ('Image (97).tif')
, ('Image (98).tif')
, ('Image (99).tif')

DECLARE @DocumentName as nvarchar(50)

DECLARE DocumentNames CURSOR FAST_FORWARD FOR

SELECT DocumentName FROM #Documents

OPEN DocumentNames
FETCH NEXT FROM DocumentNames
INTO @DocumentName

WHILE @@FETCH_STATUS = 0
BEGIN
-- do row specific stuff here
SET @FullName = @Path + @DocumentName
PRINT 'Document Name: ' + @FullName

SET @SQLStmt = 'DECLARE @img AS VARBINARY(MAX);
  SELECT @img = CAST(bulkcolumn AS VARBINARY(MAX))
  FROM
  OPENROWSET(BULK ''' + @FullName + ''', SINGLE_BLOB)
  AS x;
  INSERT INTO dbo.Item
  (
    ItemIdentifier
    , ItemNumber
    , ItemDescription
    , ImagePath
    , ItemImage
    , ItemImageType
  )
  SELECT NEWID()
    , ''' + @DocumentName + '''' +
    ', ''' + @DocumentName + '''' +
    ', ''' + @FullName + '''' +
    ', @img' +
    ', ''.tiff'';'

EXEC sp_executesql @SQLStmt
--PRINT @SQLStmt

FETCH NEXT FROM DocumentNames
INTO @DocumentName
END

CLOSE DocumentNames
DEALLOCATE DocumentNames

/* Create Full Text Index */
IF EXISTS(
	SELECT * 
	  FROM sys.fulltext_indexes
      JOIN sys.tables
        ON sys.tables.object_id = sys.fulltext_indexes.object_id
	 WHERE sys.tables.name = 'items'
)
DROP FULLTEXT INDEX ON dbo.item
GO
CREATE FULLTEXT INDEX ON dbo.item (ItemImage TYPE COLUMN ItemImageType) 
	KEY INDEX PK_ItemID
	ON ItemImageFTCatalog
	WITH (CHANGE_TRACKING = AUTO, STOPLIST = SYSTEM)
GO

/* Check row count - comment out the filestream column 
    We don't need to see the binary data in SSMS */
SELECT TOP (1000) [ItemID]
      ,[ItemIdentifier]
      ,[ItemNumber]
      ,[ItemDescription]
      ,[ImagePath]
      ,[ItemImageType]
      --,[ItemImage]
  FROM [WhatsUpDoc_Filestream].[dbo].[Item]

/* This shows the count of documents per key word */
SELECT *
FROM sys.dm_fts_index_keywords(DB_ID('WhatsUpDoc_Filestream'), OBJECT_ID('item'))
ORDER BY document_count DESC

/* This shows the count of documents in the Full Text Catlog */
SELECT FULLTEXTCATALOGPROPERTY('ItemImageFTCatalog','ItemCount') AS DocumentsInFullTextCatalog
