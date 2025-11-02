resource "aws_budgets_budget" "eventbridge_monthly" {
  count        = length(var.notification_emails) > 0 ? 1 : 0
  name         = "eventbridge-monthly-budget"
  budget_type  = "COST"
  limit_amount = tostring(var.budget_limit)
  limit_unit   = upper(var.currency)
  time_unit    = upper(var.time_unit)

  cost_filters = {
    Service = "Amazon EventBridge"
  }

  dynamic "notification" {
    for_each = local.budget_notifications
    content {
      comparison_operator = "GREATER_THAN"
      notification_type   = notification.value.type
      threshold           = var.budget_limit
      threshold_type      = "ABSOLUTE_VALUE"

      dynamic "subscriber" {
        for_each = var.notification_emails
        content {
          address           = subscriber.value
          subscription_type = "EMAIL"
        }
      }
    }
  }
}
