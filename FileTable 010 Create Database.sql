/* Introduced with SQL 2012 File Table 
   Uses filestream technology, but offers interactivity through the Windows file system
   Ability to access unstructured data files is granted through a special file share
   Database administrators can define indexes, constraints and triggers
    however the columns and system defined constrains cannot be altered or dropped. 
   Also, in order to enable the FILESTREAM feature you need to be a member of the 
    SYSADMIN or SERVERADMIN fixed server roles
*/

/* This enables xp_cmdshell in order to create the special File Table sub-directory
   If you use sp_sudir instead you should not need xp_cmdshell
*/
USE master
GO
EXEC sp_configure 'show advanced options', 1;
GO
RECONFIGURE;
GO
EXEC sp_configure 'xp_cmdshell', 1;  --use sp_subdir might not need xp_cmdshell
GO
RECONFIGURE;
GO
EXEC xp_cmdshell 'IF NOT EXIST C:\Data\WhatsUpDoc_FileTable MKDIR C:\Data\WhatsUpDoc_FileTable';
GO

/* Database creation is similar to filestream method except 
    FILESTREAM is designated at the database level WITH
     NON_TRANSACTED_ACCESS = FULL
	 DIRECTORY_NAME = N'WhatsUpDoc_FileTable'
   Server level config - these two setting must be enabled
    Enable FILESTREAM for Transact-SQL access
	Enable FILESTREAM for file I/O access
*/
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'WhatsUpDoc_FileTable') BEGIN
ALTER DATABASE WhatsUpDoc_FileTable SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE WhatsUpDoc_FileTable;
END;
CREATE DATABASE WhatsUpDoc_FileTable
WITH FILESTREAM
( 
NON_TRANSACTED_ACCESS = FULL,
DIRECTORY_NAME = N'WhatsUpDoc_FileTable'
);
GO
/* Add a FileGroup that can be used for FILESTREAM */
ALTER DATABASE WhatsUpDoc_FileTable
ADD FILEGROUP WhatsUpDoc_FileTable_FG
CONTAINS FILESTREAM;
GO
/* Add the file to the FILESTREAM filegroup above designating the filestream folder */
ALTER DATABASE WhatsUpDoc_FileTable
ADD FILE
(
NAME= 'WhatsUpDoc_FileTable_File',
FILENAME = 'C:\Data\WhatsUpDoc_FileTable\WhatsUpDoc_FileTable_File'
)
TO FILEGROUP WhatsUpDoc_FileTable_FG;
GO

/* Size and configure user filegroup files and log files */
USE [master]
ALTER DATABASE [WhatsUpDoc_FileTable] MODIFY FILE ( NAME = N'WhatsUpDoc_FileTable', SIZE = 131072KB )
ALTER DATABASE [WhatsUpDoc_FileTable] ADD FILEGROUP [UserFG]
ALTER DATABASE [WhatsUpDoc_FileTable] ADD FILE ( NAME = N'WhatsUpDoc_FileTableN1', FILENAME = N'C:\DATA\WhatsUpDoc_FileTableN1.ndf' , SIZE = 131072KB , FILEGROWTH = 8192KB ) TO FILEGROUP [UserFG]
ALTER DATABASE [WhatsUpDoc_FileTable] MODIFY FILE ( NAME = N'WhatsUpDoc_FileTable_log', SIZE = 131072KB )
USE [WhatsUpDoc_FileTable]
IF NOT EXISTS (SELECT name FROM sys.filegroups WHERE is_default=1 AND name = N'UserFG') ALTER DATABASE [WhatsUpDoc_FileTable] MODIFY FILEGROUP [UserFG] DEFAULT

