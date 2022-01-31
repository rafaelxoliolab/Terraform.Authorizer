variable "aws_region" {
  description = "AWS region for all resources."

  type    = string
  default = "us-east-1"
}

variable "stage_name" {
  type = string
  default = "dev"
}

variable "api_name" {
  type = string
  default = "rapid-sos-api"
}

variable "api_description" {
  type = string
  default = "mysite API"
}

variable "acm_certificate_domain" {
  type = string
  default = "*.mysite.com"
}

variable "route53_zone" {
  type = string
  default = "mysite.com"
}

variable "api_domain" {
  type = string
  default = "api.mysite.com"
}

variable "hosted_zone" {
  type = string
  default = "mysite.com"
}

variable "website_domain_name" {
  type = string
  default = "customer.mysite.com"
}

variable "certificate_domain" {
  type = string
  default = "*.mysite.com"
}

variable "azure_domain" {
  type = string
  default = "honidentitydev.onmicrosoft.com"
}

variable "azure_instance" {
  type = string
  default = "https://login.microsoftonline.com/"
}
