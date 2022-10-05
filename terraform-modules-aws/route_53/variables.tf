variable "name" {
  description   = "Nome da zona de domínio"
  type          = string
}

variable "records" {
  description   = "Objeto contendo subdominios da zona de hospedagem"
  type          = list(object({
    name    = string
    type    = string
    ttl     = number
    records = list(string)
  }))
}