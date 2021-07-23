variable "do_token" {
  type = string
  description = "digital ocean token"
  sensitive   = true
}


variable "datadog_api_key" {
  description = "datadog API key"
  type = string
  sensitive   = true
}

variable "datadog_app_key" {
  description = "datadog APP key"
  type = string
  sensitive   = true
}

variable "datadog_api_url" {
  description = "The API URL"
  type = string
  default = "https://us3.datadoghq.com/"
}