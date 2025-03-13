# Добавим в файл versions.tf провайдера
terraform {
  required_providers {
    external = {
      version = "~> 2.3.0"
    }
    local = {
      version = ">= 2.4.0"
    }
    aws = {  //подключение к aws 1 из 3 изменений (versions.tf, providers.tf, s3.tf)
      source  = "hashicorp/aws" 
      version = "~> 5.0"
    }
  }
  required_version = "~> 1.10.5"
}