locals {
  tags = {
    Environment         = "dev"
    CostCenter          = "infrateam"
    Team                = "infrateam"
    AssetUser           = "infrateam"
    AssetCustodian      = "infrateam"
    Organization        = "global"
    Automation          = "terraform"
    AssetClassification = "medium"
    Project             = "webapp"
    ApplicationName     = "nginx"
  }

  name_suffix     = "${lower(var.region_code)}-${lower(var.organization)}-${lower(var.env)}-${lower(var.project)}"
}
