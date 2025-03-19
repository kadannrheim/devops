data "external" "example" {
  program = ["echo", "{\"name\": \"somename\", \"desc\": \"somedesc\"}"]
}

resource "local_file" "example" {
  filename = "output-${terraform.workspace}.txt"  # Добавляем workspace в имя файла
  content  = templatefile("templates/template.tpl", {
    key1 = data.external.example.result.name
    key2 = data.external.example.result.desc
  })
}

locals {
  common_tags = {
    Environment = "Production"
    Project     = "MyProjectTrain"
    Owner       = "kadannr"
  }
}