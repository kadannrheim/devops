# datasources (источники данных) используются для получения информации о существующих ресурсах в облачных провайдерах или других внешних системах
data "external" "example" {
  program = ["echo",  "{\"name\": \"somename\", \"desc\": \"somedesc\"}"]

}

resource "local_file" "example" {
  filename = "output.txt"
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