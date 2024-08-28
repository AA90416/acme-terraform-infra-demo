variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}


variable "lifecycle_rules" {
  description = "List of lifecycle rules for the S3 bucket."
  type = list(object({
    id            = string
    prefix        = string
    status        = string
    transition    = optional(object({
      days          = number
      storage_class = string
    }))
    expiration    = optional(object({
      days = number
    }))
  }))
}

