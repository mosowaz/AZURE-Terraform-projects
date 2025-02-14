variable "storage" {
  type = map(object({
    prefix         = string
    container_name = string
    file_name      = string
  }))
}