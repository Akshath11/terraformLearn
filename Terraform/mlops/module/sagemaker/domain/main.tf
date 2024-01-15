resource "aws_sagemaker_domain" "main" {

  domain_name = var.sagemaker_domain_domain_name
  auth_mode   = var.sagemaker_domain_auth_mode
  vpc_id      = var.sagemaker_domain_vpc_id
  subnet_ids  = var.sagemaker_domain_subnet_ids
  retention_policy {
    home_efs_file_system = var.sagemaker_domain_home_efs_file_system
  }
  kms_key_id              = var.sagemaker_domain_kms_key_id
  app_network_access_type = var.sagemaker_domain_app_network_access_type

  default_user_settings {
    execution_role  = var.sagemaker_domain_execution_role_arn
    security_groups = var.sagemaker_domain_security_groups

    sharing_settings {
      notebook_output_option = var.sagemaker_domain_notebook_output_option
      s3_kms_key_id          = var.sagemaker_domain_s3_kms_key_id
      s3_output_path         = var.sagemaker_domain_create_sagemaker_bucket 
    }

    dynamic "tensor_board_app_settings" { 
      for_each = var.tensor_board_app_setting_list
      content {
        dynamic "default_resource_spec" {
          for_each = tensor_board_app_settings.value.DEFAULT_RESOURCE_SPEC
          content{
            instance_type               = default_resource_spec.value.INSTANCE_TYPE
            lifecycle_config_arn        = default_resource_spec.value.LIFECYCLE_CONFIG_ARN
            sagemaker_image_arn         = default_resource_spec.value.SAGEMAKER_IMAGE_ARN
            sagemaker_image_version_arn = default_resource_spec.value.SAGEMAKER_IMAGE_VERSION_ARN
          }
        }
      }
    }
    dynamic "kernel_gateway_app_settings" {
      for_each = var.kernel_gateway_app_setting_list
      content{
        dynamic "default_resource_spec" {
          for_each = kernel_gateway_app_settings.value.DEFAULT_RESOURCE_SPEC
          content{
            instance_type               = default_resource_spec.value.INSTANCE_TYPE
            lifecycle_config_arn        = default_resource_spec.value.LIFECYCLE_CONFIG_ARN
            sagemaker_image_arn         = default_resource_spec.value.SAGEMAKER_IMAGE_ARN
            sagemaker_image_version_arn = default_resource_spec.value.IMAGE_VERSION_ARN
        }
      }
        dynamic "custom_image" {
          for_each = kernel_gateway_app_settings.value.CUSTOM_IMAGE
          content{
            app_image_config_name = custom_image.value.APP_IMAGE_CONFIG_NAME
            image_name            = custom_image.value.APP_IMAGE_IMAGE_NAME
            image_version_number  = custom_image.value.APP_IMAGE_VERSION_NUMBER
        }
      }
        lifecycle_config_arns = kernel_gateway_app_settings.value.LIFECYCLE_CONFIG_ARNS
      }
    }
    
    dynamic "jupyter_server_app_settings" {
      for_each = var.jupyter_server_app_setting_list
      content{
        dynamic "default_resource_spec" {
          for_each = jupyter_server_app_settings.value.DEFAULT_RESOURCE_SPEC
          content{
            instance_type               = default_resource_spec.value.INSTANCE_TYPE
            lifecycle_config_arn        = default_resource_spec.value.LIFECYCLE_CONFIG_ARN
            sagemaker_image_arn         = default_resource_spec.value.SAGEMAKER_IMAGE_ARN
            sagemaker_image_version_arn = default_resource_spec.value.IMAGE_VERSION_ARN
          }
        }
        lifecycle_config_arns = jupyter_server_app_settings.value.LIFECYCLE_CONFIG_ARNS
      }
    }
  }
  default_space_settings {
    execution_role  = var.space_execution_role_arn
    security_groups = var.security_groups
  }
}
