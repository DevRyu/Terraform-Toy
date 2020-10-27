terraform {
    backend "s3" {
      bucket         = "test-devryu-tfstate" 
      key            = "tf/iam/terraform.tfstate" 
      region         = "ap-northeast-2"  
      encrypt        = true
      dynamodb_table = "terraform-lock"
      profile = "my_aws"
    }
}
