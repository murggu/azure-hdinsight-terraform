locals {
  tags = {
    Toolkit = "Terraform"
  }

  safe_prefix  = replace(var.prefix, "-", "")
  safe_postfix = replace(random_string.postfix.result, "-", "")

  basename = "${var.prefix}-${random_string.postfix.result}"
}