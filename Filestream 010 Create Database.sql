/* Similar setup to the last database except
    there is no need to size the data files for document storage
   Notice UserFS FILEGROUP contains filestream and only designates a folder 
   We will see later that SQL Server uses this directory and creates its
    own proprietary subdirectories and files */
USE master;
GO
DROP DATABASE IF EXISTS WhatsUpDoc_Filestream;
GO
CREATE DATABASE WhatsUpDoc_Filestream
ON PRIMARY
     (
       NAME = N'WhatsUpDoc_Filestream'
       , FILENAME = N'C:\DATA\WhatsUpDoc_Filestream.mdf'
       , SIZE = 128MB
       , MAXSIZE = UNLIMITED
       , FILEGROWTH = 128MB
     )
, FILEGROUP [UserFG] DEFAULT
    (
      NAME = N'WhatsUpDoc_FilestreamN1'
      , FILENAME = N'C:\DATA\WhatsUpDoc_FilestreamN1.ndf'
      , SIZE = 128MB
      , MAXSIZE = UNLIMITED
      , FILEGROWTH = 128MB
    )
, FILEGROUP UserFS CONTAINS FILESTREAM
    (
      NAME = WhatsUpDoc_FilestreamFS
      , FILENAME = N'C:\DATA\WhatsUpDoc_FilestreamFS'
    )
LOG ON
  (
    NAME = N'WhatsUpDoc_Filestream_log'
    , FILENAME = N'C:\LOG\WhatsUpDoc_Filestream_log.ldf'
    , SIZE = 128MB
    , MAXSIZE = 2048GB
    , FILEGROWTH = 128MB
  );
GO

