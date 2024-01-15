variable "sagemaker_domain_domain_name" {}
variable "sagemaker_domain_auth_mode" {}
variable "sagemaker_domain_vpc_id" {}
variable "sagemaker_domain_subnet_ids" {}
variable "sagemaker_domain_home_efs_file_system" {}
variable "sagemaker_domain_kms_key_id" {}
variable "sagemaker_domain_app_network_access_type" {}
variable "sagemaker_domain_execution_role_arn" {}
variable "sagemaker_domain_security_groups" {}
variable "sagemaker_domain_notebook_output_option" {}
variable "sagemaker_domain_s3_kms_key_id" {}
variable "sagemaker_domain_create_sagemaker_bucket" {}
variable "space_execution_role_arn" {}
variable "security_groups" {}





variable "tensor_board_app_setting_list" {
  type = map(object({
    DEFAULT_RESOURCE_SPEC = map(object({
      INSTANCE_TYPE = string
      LIFECYCLE_CONFIG_ARN = string
      SAGEMAKER_IMAGE_ARN = string
      SAGEMAKER_IMAGE_VERSION_ARN = string
    }))
  }))
}



variable "kernel_gateway_app_setting_list" {
  type = map(object({
    DEFAULT_RESOURCE_SPEC = map(object({
      INSTANCE_TYPE = string
      LIFECYCLE_CONFIG_ARN = string
      SAGEMAKER_IMAGE_ARN = string
      SAGEMAKER_IMAGE_VERSION_ARN = string
    }))
    CUSTOM_IMAGE = map(object({
      APP_IMAGE_CONFIG_NAME = string
      APP_IMAGE_IMAGE_NAME = string
      APP_IMAGE_VERSION_NUMBER = string
    }))
    LIFECYCLE_CONFIG_ARNS = string
  }))
}



variable "jupyter_server_app_setting_list" {
  type = map(object({
    DEFAULT_RESOURCE_SPEC = map(object({
      INSTANCE_TYPE = string
      LIFECYCLE_CONFIG_ARN = string
      SAGEMAKER_IMAGE_ARN = string
      SAGEMAKER_IMAGE_VERSION_ARN = string
    }))
    LIFECYCLE_CONFIG_ARNS = string
  }))
}







