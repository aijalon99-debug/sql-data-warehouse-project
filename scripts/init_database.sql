/*
==================================
Create Database and Schemas
==================================

This script creates a new database named 'Datawareshouse' after checking if it already exists. 
If the database exists, it is dropped and recreated. Additionally, the script sets up three schemes
within the database: 'Bronze', 'Silver', and 'Gold'.

WARNING:
Running this script will drop the entire 'Datawareshouse' databased if it exists.
All data in the data will be permanently deleted. Proceed with caution
and ensure you have proper backups running this script.
*/

--Create Database 'Datawarehouse'

USE master;
GO

-- Drop and recreate the 'Darawareshouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name= 'Datawareshouse')
BEGIN
  ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
  DROP DATABASE Datawarehouse;
END,
 GO 

--CREATE DATABASE Datawarehouse
  CREATE DATABASE Datawarehouse;
  GO

USE Datawareshouse

CREATE SCHEMA Bronze;
GO
CREATE SCHEMA Silver;
GO
CREATE SCHEMA Gold;
GO
