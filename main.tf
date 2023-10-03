terraform {
  required_version = ">= 0.13.1"

  required_providers {
    shoreline = {
      source  = "shorelinesoftware/shoreline"
      version = ">= 1.11.0"
    }
  }
}

provider "shoreline" {
  retries = 2
  debug = true
}

module "tomcat_low_available_threads_in_connection_pool" {
  source    = "./modules/tomcat_low_available_threads_in_connection_pool"

  providers = {
    shoreline = shoreline
  }
}