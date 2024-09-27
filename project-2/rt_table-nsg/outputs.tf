output "hub_public_ip" {
  value = data.terraform_remote_state.compute.outputs.hub_public_ip
}

output "hub_private_ip" {
  value = data.terraform_remote_state.compute.outputs.hub_private_ip
}

output "spokes_private_ip" {
  value = data.terraform_remote_state.compute.outputs.spokes_private_ip
}