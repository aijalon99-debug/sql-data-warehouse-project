/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source ->)
===============================================================================
Script Purpose:
This stored procedure loads data into the 'Bronze' schema from external CSV files.
It performs the following actions:
- Truncates the bronze before loading data.
- Use the 'BULK INSERT' command to load data from csv Files to Bronze Tables.

Parameters:
None
This stored procedure does not accept any parameters or return any values.

Usage Example:
EXEC Bronze_load.bronze;
=================================================================================
*/
CREATE OR ALTER PROCEDURE Bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE ();
		PRINT '=========================================';
		PRINT 'Loading Bronze Layer'
		PRINT ' ========================================';

		PRINT '-----------------------------------------';
		PRINT 'Loading CRM Tables'
		PRINT '-----------------------------------------';

		SET @start_time = GETDATE ();
		PRINT '>> Truncating Table: Bronze.crm_cust_info';
		TRUNCATE TABLE Bronze.crm_cust_info;

		PRINT '>> Inserting Date into: Bronze.crm_cust_info';
		BULK INSERT Bronze.crm_cust_info
		FROM 'C:\Users\aijal\OneDrive\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE ();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '----------'

		SET @start_time = GETDATE ();
		PRINT '>> Truncating Table: Bronze.crm_prd_info';
		TRUNCATE TABLE Bronze.crm_prd_info;

		PRINT '>> Inserting Date into: Bronze.crm_prd_info';
		BULK INSERT Bronze.crm_prd_info
		FROM 'C:\Users\aijal\OneDrive\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE ();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '----------'

		SET @start_time = GETDATE ();
		PRINT '>> Truncating Table: Bronze.crm_sls_order_details';
		TRUNCATE TABLE Bronze.crm_sls_order_details;

		PRINT '>> Inserting Date into: Bronze.crm_sls_order_details';
		BULK INSERT Bronze.crm_sls_order_details
		FROM 'C:\Users\aijal\OneDrive\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE ();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '----------'


		PRINT '-----------------------------------------';
		PRINT 'Loading ERP Tables'
		PRINT '-----------------------------------------';
	
		SET @start_time = GETDATE ();
		PRINT '>> Truncating Table:Bronze.erp_cust_az12';
		TRUNCATE TABLE Bronze.erp_cust_az12;

		PRINT '>> Inserting Date into: Bronze.erp_cust_az12';
		BULK INSERT Bronze.erp_cust_az12
		FROM 'C:\Users\aijal\OneDrive\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE ();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '----------'

		SET @start_time = GETDATE ();
		PRINT '>> Truncating Table: Bronze.erp_loc_a101';
		TRUNCATE TABLE Bronze.erp_loc_a101;

		PRINT '>> Inserting Date into: Bronze.erp_loc_a101 ';
		BULK INSERT Bronze.erp_loc_a101
		FROM 'C:\Users\aijal\OneDrive\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE ();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '----------'

		SET @start_time = GETDATE ();
		PRINT '>> Truncating Table:  Bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE Bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting Date into:Bronze.erp_px_cat_g1v2';
		BULK INSERT Bronze.erp_px_cat_g1v2
		FROM 'C:\Users\aijal\OneDrive\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE ();
		PRINT '>> Load Duration: ' + CAST (DATEDIFF (second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
		PRINT '----------'

		SET @batch_end_time = GETDATE ();
		PRINT '================================================='
		PRINT ' >> Loading Bronze Layer Completed' + CAST(DATEDIFF (second, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';

	END TRY
	BEGIN CATCH
		PRINT '==========================================='
		PRINT 'ERORR OCCURRED DURING LOADING BRONZE LAYER'
		PRINT 'ERROR Message' + ERROR_MESSAGE ();
		PRINT 'ERROR Message' + CAST(ERROR_NUMBER () AS NVARCHAR)
		PRINT 'ERROR Message' + CAST (ERROR_State () AS NVARCHAR)
		PRINT '==========================================='

	END CATCH
END
