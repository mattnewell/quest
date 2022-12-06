resource "aws_ecr_repository" "quest" {
  name                 = var.base_name
  image_tag_mutability = "MUTABLE"
  # Perhaps a bad idea in prod, useful for dev
  force_delete = "true"
  encryption_configuration {
    # AES256 is the default, but specifying makes it more clear for auditability
    encryption_type = "AES256"
  }

  image_scanning_configuration {
    scan_on_push = true
  }
}
