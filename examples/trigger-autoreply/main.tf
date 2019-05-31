# Configure the Zendesk Provider
variable "ZENDESK_ACCOUNT" { type = "string" }
variable "ZENDESK_EMAIL"   { type = "string" }
variable "ZENDESK_TOKEN"   { type = "string" }

provider "zendesk" {
  account = "${var.ZENDESK_ACCOUNT}"
  email   = "${var.ZENDESK_EMAIL}"
  token   = "${var.ZENDESK_TOKEN}"
}

module "trigger_autoreply" {
  source = "../../modules/trigger-autoreply"

  title   = "自動返信"
  subject = "お問い合わせありがとうございます"
  body    = <<BODY
このたびは弊社製品に関するお問い合わせをいただきありがとうございます。

このメッセージは自動返信です。
担当者による調査のうえ、あらためてご連絡いたしますので今しばらくお待ちください。

ぬこすけ
BODY
}
