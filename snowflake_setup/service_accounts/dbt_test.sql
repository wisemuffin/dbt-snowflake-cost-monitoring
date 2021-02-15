//=============================================================================
// create warehouses
//=============================================================================
USE ROLE SYSADMIN;

// test warehouse
CREATE WAREHOUSE
    CLOUD_COST_MONITORING_TEST_WH
    COMMENT='Warehouse for powering CI test activities for the cloud cost monitoring project'
    WAREHOUSE_SIZE=XSMALL
    AUTO_SUSPEND=60
    INITIALLY_SUSPENDED=TRUE;
//=============================================================================


//=============================================================================
// create object access roles for warehouses
//=============================================================================
USE ROLE SECURITYADMIN;

// test for ci (not for humans)
CREATE ROLE CLOUD_COST_MONITORING_TEST_WH_USAGE;

// grant all roles to sysadmin (always do this)
GRANT ROLE CLOUD_COST_MONITORING_TEST_WH_USAGE TO ROLE SYSADMIN;
//=============================================================================


//=============================================================================
// grant privileges to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;

// test permissions
GRANT USAGE ON WAREHOUSE CLOUD_COST_MONITORING_TEST_WH TO ROLE CLOUD_COST_MONITORING_TEST_WH_USAGE;
//=============================================================================


//=============================================================================
// create business function roles and grant access to object access roles
//=============================================================================
USE ROLE SECURITYADMIN;
 
// transformer roles
CREATE ROLE CLOUD_COST_MONITORING_TEST_TRANSFORMER;
 
// grant all roles to sysadmin (always do this)
GRANT ROLE CLOUD_COST_MONITORING_TEST_TRANSFORMER TO ROLE SYSADMIN;

// test OA roles
GRANT ROLE CLOUD_COST_MONITORING_TEST_READ_WRITE TO ROLE CLOUD_COST_MONITORING_TEST_TRANSFORMER;
GRANT ROLE CLOUD_COST_MONITORING_TEST_WH_USAGE   TO ROLE CLOUD_COST_MONITORING_TEST_TRANSFORMER;
GRANT ROLE FIVETRAN_READ_ROLE                    TO ROLE CLOUD_COST_MONITORING_TEST_TRANSFORMER;
//=============================================================================


//=============================================================================
// create service account
//=============================================================================
USE ROLE SECURITYADMIN;
 
// create service account
CREATE USER 
  DBT_CLOUD_COST_MONITORING_TEST_SERVICE_ACCOUNT
  PASSWORD = 'my cool password here' // use your own password 
  COMMENT = 'Service account for DBT CI/CD in the test environment of the Cloud Cost Monitoring project.'
  DEFAULT_WAREHOUSE = CLOUD_COST_MONITORING_TEST_WH
  DEFAULT_ROLE = CLOUD_COST_MONITORING_TEST_TRANSFORMER
  MUST_CHANGE_PASSWORD = FALSE;

// grant permissions to service account
GRANT ROLE CLOUD_COST_MONITORING_TEST_TRANSFORMER TO USER DBT_CLOUD_COST_MONITORING_TEST_SERVICE_ACCOUNT;
//=============================================================================
