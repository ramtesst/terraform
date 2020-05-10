resource "random_string" "random" {
    length = 16
    special = true
    override_special = "/@£$"
    provisioner "local-exec" {
        command = "sleep 2; echo slept"
    }
}