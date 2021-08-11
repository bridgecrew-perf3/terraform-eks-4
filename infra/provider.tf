provider "aws" {
  region                  = var.region
  shared_credentials_file = pathexpand(var.shared_credentials_file)
  profile                 = var.profile
}
