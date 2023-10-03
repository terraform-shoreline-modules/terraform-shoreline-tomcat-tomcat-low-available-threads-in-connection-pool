resource "shoreline_notebook" "tomcat_low_available_threads_in_connection_pool" {
  name       = "tomcat_low_available_threads_in_connection_pool"
  data       = file("${path.module}/data/tomcat_low_available_threads_in_connection_pool.json")
  depends_on = [shoreline_action.invoke_change_connection_pool_size,shoreline_action.invoke_stop_start_tomcat_and_increase_memory]
}

resource "shoreline_file" "change_connection_pool_size" {
  name             = "change_connection_pool_size"
  input_file       = "${path.module}/data/change_connection_pool_size.sh"
  md5              = filemd5("${path.module}/data/change_connection_pool_size.sh")
  description      = "Increase the size of the connection pool to allow for more available threads."
  destination_path = "/agent/scripts/change_connection_pool_size.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "stop_start_tomcat_and_increase_memory" {
  name             = "stop_start_tomcat_and_increase_memory"
  input_file       = "${path.module}/data/stop_start_tomcat_and_increase_memory.sh"
  md5              = filemd5("${path.module}/data/stop_start_tomcat_and_increase_memory.sh")
  description      = "Increase the memory allocation to the Tomcat server to allow for more threads."
  destination_path = "/agent/scripts/stop_start_tomcat_and_increase_memory.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_change_connection_pool_size" {
  name        = "invoke_change_connection_pool_size"
  description = "Increase the size of the connection pool to allow for more available threads."
  command     = "`chmod +x /agent/scripts/change_connection_pool_size.sh && /agent/scripts/change_connection_pool_size.sh`"
  params      = ["PATH_TO_SERVER_XML_FILE","PATH_TO_TOMCAT_DIRECTORY","NEW_CONNECTION_POOL_SIZE"]
  file_deps   = ["change_connection_pool_size"]
  enabled     = true
  depends_on  = [shoreline_file.change_connection_pool_size]
}

resource "shoreline_action" "invoke_stop_start_tomcat_and_increase_memory" {
  name        = "invoke_stop_start_tomcat_and_increase_memory"
  description = "Increase the memory allocation to the Tomcat server to allow for more threads."
  command     = "`chmod +x /agent/scripts/stop_start_tomcat_and_increase_memory.sh && /agent/scripts/stop_start_tomcat_and_increase_memory.sh`"
  params      = ["NEW_MEMORY_SIZE"]
  file_deps   = ["stop_start_tomcat_and_increase_memory"]
  enabled     = true
  depends_on  = [shoreline_file.stop_start_tomcat_and_increase_memory]
}

