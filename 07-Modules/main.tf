module "owenmodule" {
  source = "./OwenModule"
}

output "resource_primary_key" {
  value = module.owenmodule.primarykey
  sensitive = true
}