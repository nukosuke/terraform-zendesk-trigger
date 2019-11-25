resource "zendesk_trigger" "trigger-autoreply" {
  title  = var.title
  active = var.active

  all {
    field    = "role"
    operator = "is"
    value    = "end_user"
  }

  all {
    field    = "update_type"
    operator = "is"
    value    = "Create"
  }

  all {
    field    = "status"
    operator = "is_not"
    value    = "solved"
  }

  action {
    field = "notification_user"
    value = jsonencode([
      "requester_id",
      var.subject,
      var.body
    ])
  }
}
