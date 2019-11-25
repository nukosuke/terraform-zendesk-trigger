resource "zendesk_ticket_field" "turn-counter" {
  title = "Turn Counter"
  type  = "text"
}

#
# 1st inbound
#
resource "zendesk_trigger" "trigger_first_turn" {
  title = "Add tag: [Turn 1]"

  all {
    field    = "update_type"
    operator = "is"
    value    = "Created"
  }

  all {
    field    = "role"
    operator = "is"
    value    = "end_user"
  }

  action {
    field = "custom_fields_${zendesk_ticket_field.turn-counter.id}"
    value = "Turn 1"
  }
}

#
# 2 ~ Nth inbound
#
resource "zendesk_trigger" "trigger_turn" {
  count    = var.max_count - 1
  position = var.start_position + 1 + count.index
  title    = "Change tag: [Turn ${count.index + 1} (REPLIED)] -> [Turn ${count.index + 2}${count.index == var.max_count - 2 ? "+" : ""}]"

  all {
    field    = "update_type"
    operator = "is"
    value    = "Change"
  }

  all {
    field    = "role"
    operator = "is"
    value    = "end_user"
  }

  all {
    field    = "comment_is_public"
    operator = "is"
    value    = "true"
  }

  all {
    field    = "custom_fields_${zendesk_ticket_field.turn-counter.id}"
    operator = "is"
    value    = "Turn ${count.index + 1} (REPLIED)"
  }

  action {
    field = "custom_fields_${zendesk_ticket_field.turn-counter.id}"
    value = "Turn ${count.index + 2}${count.index == var.max_count - 2 ? "+" : ""}"
  }
}

#
# 1 ~ N-1th outbound (REPLIED)
#
resource "zendesk_trigger" "turn-replied" {
  count    = var.max_count - 1
  title    = "Change tag: [Turn ${count.index + 1}] -> [Turn ${count.index + 1} (REPLIED)]"

  all {
    field    = "update_type"
    operator = "is"
    value    = "Change"
  }

  all {
    field    = "role"
    operator = "is_not"
    value    = "end_user"
  }

  all {
    field    = "comment_is_public"
    operator = "is"
    value    = "true"
  }

  all {
    field    = "custom_fields_${zendesk_ticket_field.turn-counter.id}"
    operator = "is"
    value    = "Turn ${count.index + 1}"
  }

  action {
    field = "custom_fields_${zendesk_ticket_field.turn-counter.id}"
    value = "Turn ${count.index + 1} (REPLIED)"
  }
}
