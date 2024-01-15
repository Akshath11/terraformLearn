resource "aws_sagemaker_user_profile" "default_user" {
  for_each = var.user_profile_list
  domain_id         = lookup(each.value,"DOMAIN_ID")
  user_profile_name = lookup(each.value,"USER_PROFILE_NAME")

  user_settings {
    execution_role  =  var.execution_role_userprofile
    security_groups =  lookup(each.value,"SECURITY_GROUPS")
  }
}
