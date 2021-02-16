//=============================================================================
// inital schema setup
//=============================================================================
// schema
CREATE SCHEMA IF NOT EXISTS PC_FIVETRAN_DB.HASHMAP_SNOWFLAKE_USEAGE;

// warehouse metering history
CREATE TABLE IF NOT EXISTS
    PC_FIVETRAN_DB.HASHMAP_SNOWFLAKE_USEAGE.WAREHOUSE_METERING_HISTORY
AS (
    SELECT
        *,
        CURRENT_TIMESTAMP as INGESTION_TIME
    FROM
        SNOWFLAKE.ACCOUNT_USAGE.WAREHOUSE_METERING_HISTORY
);
//=============================================================================