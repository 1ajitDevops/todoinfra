resource "azurerm_network_interface" "nic" {
  name                = var.nic-name
  location            = var.nic-location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = data.azurerm_public_ip.pip.id
    
  }
}

resource "azurerm_linux_virtual_machine" "virtual-machine" {
  name                = var.virtual-machine-name
  resource_group_name = var.resource_group_name
  location            = var.resource_location
  size                = "Standard_B1s"
  admin_username      = var.admin-username
  admin_password      = var.admin-password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}