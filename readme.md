# S3 and CloudFront Hosted Static Website

This repository contains Terraform code and files for hosting a simple static website using CloudFront and S3.

For step-by-step instructions, please refer to this [article](https://medium.com/@efar3200/hosting-website-with-amazon-cloudfront-and-s3-1881c14bd038).

---

## Project Structure

### `provider.tf`
- Contains Terraform code to configure the AWS provider.

### `s3.tf`
- Contains Terraform code for creating the S3 bucket and setting up the necessary bucket policy.

### `cloudfront.tf`
- Contains Terraform code for configuring the CloudFront distribution.

### `output.tf`
- Outputs the CloudFront distribution domain name to your local terminal.

