locals {
  user_data = templatefile("${path.module}/userdata/user_data_container.sh.tpl", {
    container_image = var.container_image
  })
}
