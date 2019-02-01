#!/bin/bash
echo "Clearning generated files domain1..."
rm -rf /sola-glassfish/glassfish/glassfish/domains/domain1/osgi-cache/
rm -rf /sola-glassfish/glassfish/glassfish/domains/domain1/generated/

echo "Clearning generated files geoserver..."
rm -rf /sola-glassfish/glassfish/glassfish/domains/geoserver/osgi-cache/
rm -rf /sola-glassfish/glassfish/glassfish/domains/geoserver/generated/

echo "Starting geoserver...."
/sola-glassfish/glassfish/bin/asadmin start-domain geoserver
sleep 30
echo "Starting domain1...."
/sola-glassfish/glassfish/bin/asadmin start-domain --verbose domain1
