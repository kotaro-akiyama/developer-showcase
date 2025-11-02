locals {
  repository_id           = "${var.github_owner}/${var.github_repo}"
  sanitized_branch        = regexreplace(lower(var.github_branch), "[^a-z0-9-]", "-")
  sanitized_repo          = regexreplace(lower(var.github_repo), "[^a-z0-9-]", "-")
  base_name               = trim(regexreplace("${local.sanitized_repo}-${local.sanitized_branch}", "-{2,}", "-"), "-")
  effective_artifact_name = var.artifact_bucket_name != "" ? var.artifact_bucket_name : "${local.base_name}-artifacts"
  artifact_bucket_name    = substr(local.effective_artifact_name, 0, 63)
  logs_bucket_name        = substr("${local.base_name}-cf-logs", 0, 63)
  pipeline_name           = substr("${local.base_name}-pipeline", 0, 100)
  codebuild_project_name  = substr("${local.base_name}-build", 0, 255)
  oac_name                = substr("${local.base_name}-oac", 0, 128)

  common_tags = {
    Repository = local.repository_id
    Branch     = var.github_branch
  }
}

module "static_site_pipeline" {
  source = "./modules/static_site_pipeline"

  aws_region                  = var.aws_region
  aws_account_id              = var.aws_account_id
  site_bucket_name            = var.site_bucket_name
  artifact_bucket_name        = local.artifact_bucket_name
  repository_id               = local.repository_id
  github_branch               = var.github_branch
  cloudfront_logs_bucket_name = local.logs_bucket_name
  pipeline_name               = local.pipeline_name
  codebuild_project_name      = local.codebuild_project_name
  oac_name                    = local.oac_name
  cloudfront_price_class      = var.cloudfront_price_class
  connection_arn              = var.connection_arn
  cloudfront_waf_acl_arn      = var.cloudfront_waf_acl_arn
  tags                        = local.common_tags
}
