provider "azurerm" { }

resource "azurerm_resource_group" "test" {
  name = "ubuntutestrg"
  location = "brazilsouth"
}

resource "azurerm_virtual_network" "test" {
  name = "ubuntutestvn"
  location = "brazilsouth"
  resource_group_name = "${azurerm_resource_group.test.name}"
  address_space = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "test" {
  name = "ubuntutestsn"
  resource_group_name = "${azurerm_resource_group.test.name}"
  virtual_network_name = "${azurerm_virtual_network.test.name}"
  address_prefix = "10.0.2.0/24"
}

resource "azurerm_network_interface" "test" {
  name = "ubuntutestni"
  location = "brazilsouth"
  resource_group_name = "${azurerm_resource_group.test.name}"

  ip_configuration {
    name = "ubuntutestcfg"
    subnet_id = "${azurerm_subnet.test.id}"
    private_ip_address_allocation = "dynamic"
  }
}

resource "azurerm_storage_account" "test" {
  name = "ubuntutestsa"
  resource_group_name = "${azurerm_resource_group.test.name}"
  location = "brazilsouth"
  account_tier = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "test" {
  name = "vhds"
  resource_group_name = "${azurerm_resource_group.test.name}"
  storage_account_name = "${azurerm_storage_account.test.name}"
  container_access_type = "private"
}

resource "azurerm_virtual_machine" "test" {
  name = "ubuntutestvm"
  location = "brazilsouth"
  resource_group_name = "${azurerm_resource_group.test.name}"
  network_interface_ids = ["${azurerm_network_interface.test.id}"]
  vm_size = "Standard_A0"

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name          = "myosdisk1"
    vhd_uri       = "${azurerm_storage_account.test.primary_blob_endpoint}${azurerm_storage_container.test.name}/myosdisk1.vhd"
    caching       = "ReadWrite"
    create_option = "FromImage"
  }

  os_profile {
    computer_name  = "hostname"
    admin_username = "testadmin"
    admin_password = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }
}

resource "azurerm_public_ip" "test" {
  name = "ubuntutestpip"
  location = "brazilsouth"
  resource_group_name = "${azurerm_virtual_machine.test.resource_group_name}"
  public_ip_address_allocation = "dynamic"
}
