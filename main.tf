#  Template file JSON body for API POST request to login to Silverline to get token
data "template_file" "login" {
  template = file("./login.tpl")

  vars = {
    email    = var.email,
    password = var.password
  }
}

#  API POST request to login to Silverline to get token.  Output is written to file (not secure), but there is currenlty no other option with Terraform until either:
#    - terraform external data source allows muli-level json query, or...
#    - terraform http data source allows POST (currently only GET is allowed), or...
#    - f5 create a Silverline Terraform Provider
resource "null_resource" "login" {

  provisioner "local-exec" {
    command = "curl -k -X POST -H 'Content-type: application/json' --data-raw '${data.template_file.login.rendered}' ${var.silverline_login_url} > ${path.module}/login_response.json"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -f ${path.module}/login_response.json"
  }
}

#  Open the login_response file
data "local_file" "login_response" {
  filename   = "${path.module}/login_response.json"
  depends_on = [null_resource.login]
}

#  Output the 'auth_token' element of the login_response for testing
# output "auth_token" {
#   value = jsondecode(data.local_file.login_response.content).data.attributes.auth_token
# }


# Get a list of proxies using the token in the X-Authorization-Token header.  Write output to get_proxies_response.json file.
resource "null_resource" "get_proxies" {

  provisioner "local-exec" {
    command = "curl -k -X GET -H 'Content-type: application/json' -H 'X-Authorization-Token: ${jsondecode(data.local_file.login_response.content).data.attributes.auth_token}' ${var.silverline_proxies_url} > ${path.module}/get_proxies_response.json"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -f ${path.module}/get_proxies_response.json"
  }
}

# # Create a new Silverline proxy with API POST..
resource "null_resource" "create_proxy" {

  provisioner "local-exec" {
    command = "curl --location --request POST -H 'Content-type: application/json' --data-raw '${templatefile("./create_proxy_json.tpl", { var1  = var.proxy_var_one, var2  = var.proxy_var_two } )}' -H 'X-Authorization-Token: ${jsondecode(data.local_file.login_response.content).data.attributes.auth_token}' ${var.silverline_proxies_url} > ${path.module}/create_proxy_response.json"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "rm -f ${path.module}/create_proxy_response.json"
  }
}

#  Open the proxy create response file
data "local_file" "create_proxy_response" {
  filename   = "${path.module}/create_proxy_response.json"
  depends_on = [null_resource.create_proxy]
}

#  Output the create proxy response for testing
output "proxy_response" {
  value = jsondecode(data.local_file.create_proxy_response.content)
}