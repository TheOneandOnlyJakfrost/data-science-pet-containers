#! /bin/bash

echo "Copying the code to the container"
docker cp geocoder_scripts containers_postgis_1:/usr/local/src/
docker exec -u root containers_postgis_1 \
  chown -R postgres:postgres /usr/local/src/geocoder_scripts
docker exec -u root containers_postgis_1 \
  chmod +x /usr/local/src/geocoder_scripts/create-geocoder-database.bash
echo "Populating the database - will take some time!"
echo ""
echo ""
docker exec -u postgres -w /usr/local/src/geocoder_scripts containers_postgis_1 \
  /usr/local/src/geocoder_scripts/create-geocoder-database.bash
echo "Retriving database backup"
docker cp containers_postgis_1:/gisdata/geocoder.backup ../../containers/Raw
echo "Retriving shapefile archive"
docker cp containers_postgis_1:/gisdata/tiger.zip ../../containers/Raw
echo "Retriving database population scripts"
docker cp containers_postgis_1:/gisdata/nation.bash ../../containers/Raw
docker cp containers_postgis_1:/gisdata/oregon.bash ../../containers/Raw
