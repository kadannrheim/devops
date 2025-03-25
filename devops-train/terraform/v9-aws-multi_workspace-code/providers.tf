provider "local" {}

provider "external" {}

provider "aws" { ////подключение к aws 1 из 3 изменений (versions.tf, providers.tf, s3.tf)
  region = "eu-west-2"
}