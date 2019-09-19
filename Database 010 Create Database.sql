/* Drop databases if they exist */
DROP DATABASE IF EXISTS [WhatsUpDoc_Database]
DROP DATABASE IF EXISTS [WhatsUpDoc_Filestream]
DROP DATABASE IF EXISTS [WhatsUpDoc_FileTable]

/* Tells you if the Full-Text Engine Service is enabled */
select serverproperty('IsFullTextInstalled')

/* Indicates whether operating system word breakers, stemmers, and filters are registered 
   and used with this instance of SQL Server */
EXEC sp_fulltext_service @action='load_os_resources', @value=1;

/* Indicates whether only signed binaries are loaded by the Full-Text Engine. 
   By default, only trusted, signed binaries are loaded.*/
EXEC sp_fulltext_service @action='verify_signature', @value=0;

/* Returns a row for each document type that is available 
   for full-text indexing operations.*/
SELECT document_type, path
FROM sys.fulltext_document_types
WHERE document_type IN ('.tif', '.pdf')

/* Create database - This is no different than any other general purpose database you would create 
   */
USE master
GO
DROP DATABASE IF EXISTS WhatsUpDoc_Database
GO
CREATE DATABASE WhatsUpDoc_Database
 ON  PRIMARY 
( NAME = N'WhatsUpDoc_Database', FILENAME = N'C:\DATA\WhatsUpDoc_Database.mdf' , SIZE = 128MB , MAXSIZE = UNLIMITED, FILEGROWTH = 128MB ), 
 FILEGROUP [UserFG]  DEFAULT
( NAME = N'WhatsUpDoc_DatabaseN1', FILENAME = N'C:\DATA\WhatsUpDoc_DatabaseN1.ndf' , SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 512MB )
, ( NAME = N'WhatsUpDoc_DatabaseN2', FILENAME = N'C:\DATA\WhatsUpDoc_DatabaseN2.ndf' , SIZE = 1024MB , MAXSIZE = UNLIMITED, FILEGROWTH = 512MB )
 LOG ON 
( NAME = N'WhatsUpDoc_Database_log', FILENAME = N'C:\LOG\WhatsUpDoc_Database_log.ldf' , SIZE = 128MB , MAXSIZE = 2048GB , FILEGROWTH = 128MB)
GO


