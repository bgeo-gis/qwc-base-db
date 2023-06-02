#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
  CREATE ROLE qgis_server LOGIN PASSWORD 'qgis_server';
  CREATE ROLE qwc_admin LOGIN PASSWORD 'qwc_admin';
  CREATE ROLE qwc_service LOGIN PASSWORD 'qwc_service';
  CREATE ROLE qwc_service_write LOGIN PASSWORD 'qwc_service_write';

  CREATE DATABASE qwc_configdb;
  COMMENT ON DATABASE qwc_configdb IS 'Config DB for qwc-services';
EOSQL

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" -d qwc_configdb <<-EOSQL
  CREATE SCHEMA qwc_config AUTHORIZATION qwc_admin;
  COMMENT ON SCHEMA qwc_config IS 'Configurations for qwc-services';
EOSQL
