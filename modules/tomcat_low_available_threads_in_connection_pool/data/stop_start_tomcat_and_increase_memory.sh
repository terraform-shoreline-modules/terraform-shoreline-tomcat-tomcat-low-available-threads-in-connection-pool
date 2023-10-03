

#!/bin/bash



# Stop the Tomcat server

sudo systemctl stop tomcat



# Increase the memory allocation by updating the CATALINA_OPTS environment variable in the Tomcat configuration file

sudo sed -i 's/export CATALINA_OPTS=/export CATALINA_OPTS="-Xms${NEW_MEMORY_SIZE}G -Xmx${NEW_MEMORY_SIZE}G"/g' /etc/tomcat/catalina.sh



# Start the Tomcat server

sudo systemctl start tomcat