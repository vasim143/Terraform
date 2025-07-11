terraform {
  backend "s3" {
    bucket         = "vasimbucketteststatefile"       # Your S3 bucket
    key            = "day-6/terraform.tfstate"        # Path inside the bucket
    region         = "us-east-1"                      # Your AWS region
    dynamodb_table = "terraform-lock-table"           # For state locking
    encrypt        = true                              # Encrypt the state file
  }
}
