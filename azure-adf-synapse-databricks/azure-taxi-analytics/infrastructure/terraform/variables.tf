variable "resource_group_name" {
  default = "taxi-analytics-rg"
}

variable "location" {
  default = "East US"
}

variable "storage_account_name" {
  # must be unique globally, 3–24 chars, lowercase
  default = "taxianalyticssa1234"
}

variable "eventhub_namespace" {
  default = "taxi-eventhub-ns"
}

variable "eventhub_name" {
  default = "taxi-stream"
}
