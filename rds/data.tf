# Retrieve username (String)
data "aws_ssm_parameter" "db_username" {
  name = "/rds/db_username"
}

# Retrieve password (SecureString)
data "aws_ssm_parameter" "db_password" {
  name            = "/rds/db_password"
  with_decryption = true
}