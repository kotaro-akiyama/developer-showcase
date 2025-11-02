locals {
  project     = var.project
  environment = var.environment

  default_tags = {
    Project     = local.project
    Environment = local.environment
    ManagedBy   = "terraform"
  }

  budget_notifications = [
    { type = "ACTUAL" },
    { type = "FORECASTED" }
  ]
}
