variable "user_profile_list" {
  description = "A map of maps containing user profile attributes for SageMaker."
  type = map(object({
    DOMAIN_ID         : string
    USER_PROFILE_NAME : string
    SECURITY_GROUPS   : list(string)
  }))
  default = {}
}
variable "execution_role_userprofile" {}