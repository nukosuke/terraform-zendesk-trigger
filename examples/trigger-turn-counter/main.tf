# Configure the Zendesk Provider
variable "ZENDESK_ACCOUNT" { type = "string" }
variable "ZENDESK_EMAIL"   { type = "string" }
variable "ZENDESK_TOKEN"   { type = "string" }

provider "zendesk" {
  account = "${var.ZENDESK_ACCOUNT}"
  email   = "${var.ZENDESK_EMAIL}"
  token   = "${var.ZENDESK_TOKEN}"
}

module "turn-counter" {
  source = "../../modules/trigger-turn-counter"

  max_count      = 10
  start_position = 8
}
