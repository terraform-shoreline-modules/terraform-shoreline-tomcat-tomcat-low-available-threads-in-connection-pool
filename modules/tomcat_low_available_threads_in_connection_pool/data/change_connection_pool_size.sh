bash

#!/bin/bash



# Define variables

TOMCAT_HOME=${PATH_TO_TOMCAT_DIRECTORY}

SERVER_XML=${PATH_TO_SERVER_XML_FILE}

CONNECTION_POOL_SIZE=${NEW_CONNECTION_POOL_SIZE}



# Stop Tomcat server

$TOMCAT_HOME/bin/shutdown.sh



# Replace connection pool size in server.xml

sed -i "s/maxTotal=\"[0-9]*\"/maxTotal=\"$CONNECTION_POOL_SIZE\"/" $SERVER_XML



# Start Tomcat server

$TOMCAT_HOME/bin/startup.sh