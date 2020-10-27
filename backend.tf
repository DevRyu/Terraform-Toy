terraform {
    backend "s3" {
      bucket         = "test-devryu-tfstate" 
      key            = "tf/terraform.tfstate" 
      region         = "ap-northeast-2"  
      encrypt        = true
      dynamodb_table = "terraform-lock"
      profile = "my_aws"
    }
}
