module "azurerm_resource_group" {
  source = "../Child/azurerm_Resource_group"
  resource_group_name = "RG-1"
  resource_location = "CentralIndia"
}

module "azurerm_virtual_network" {
  source = "../Child/azurerm_virtual_network"
  depends_on = [ module.azurerm_resource_group ]
  virtual_network_name = "tondu-virtual_network"
  virtual_network_location = "CentralIndia"
  resource_group_name ="RG-1"
  address_space = ["10.0.0.0/16"]
}

module "azurerm_frontend-subnet" {
  depends_on = [ module.azurerm_virtual_network ]
  source = "../Child/azurerm_Subnet"
  subnet-name ="frontend-subnet"
  resource_group_name = "RG-1"
  virtual_network_name ="tondu-virtual_network"
  address_prefixes = ["10.0.1.0/24"] 
}

module "azurerm_backend-subnet" {
  depends_on = [ module.azurerm_virtual_network ]
  source = "../Child/azurerm_Subnet"
  subnet-name ="backend-subnet"
  resource_group_name = "RG-1"
  virtual_network_name ="tondu-virtual_network"
  address_prefixes = ["10.0.2.0/24"] 
}

module "frontend-pip" {
  source = "../Child/azurerm_Public_IP"
  depends_on = [ module.azurerm_resource_group ]
  public_IP_name = "frontend-pip"
  resource_group_name ="RG-1"
  resource_location ="Centralindia"
  allocation_method = "Static"
}

module "backend-pip" {
  source = "../Child/azurerm_Public_IP"
  depends_on = [ module.azurerm_resource_group ]
  public_IP_name = "backend-pip"
  resource_group_name ="RG-1"
  resource_location ="Centralindia"
  allocation_method = "Static"
}

module "frontend-virtual_machine" {
  source = "../Child/azurerm_virtual_machine"
  depends_on = [ module.azurerm_frontend-subnet ]
  nic-name      ="tondu-nic-frontend"
  nic-location   ="centralindia"
  resource_group_name ="RG-1"
  virtual-machine-name ="tondu-frontend-vm"
  resource_location ="centralindia"
  admin-username ="adminuser"
  admin-password = "Cloud@2020cloud"
  public_IP_name = "frontend-pip"
  subnet-name = "frontend-subnet"
  virtual_network_name = "tondu-virtual_network"
  
}


module "backend-virtual_machine" {
  source = "../Child/azurerm_virtual_machine"
  depends_on = [ module.azurerm_backend-subnet ]
  nic-name      ="tondu-nic-backend"
  nic-location   ="centralindia"
  resource_group_name ="RG-1"
  virtual-machine-name ="tondu-backend-vm"
  resource_location ="centralindia"
  admin-username ="adminuser"
  admin-password = "Cloud@2020cloud"
  public_IP_name = "backend-pip"
  subnet-name = "backend-subnet"
  virtual_network_name = "tondu-virtual_network"
  
}

module "azurerm_sql_server" {
  source = "../Child/azurerm_sql_server"
  mssql-server-name = "tondu-server"
  resource_group_name ="RG-1"
  location = "Centralindia"
  mssql-version ="12.0"
  administrator_login ="adminuser"
  administrator_login_password = "Cloud2025cloud"
 }

 module "azurerm_mssql_database" {
  source = "../Child/azurerm_sql_database"
  depends_on = [ module.azurerm_sql_server ]
  sqldatabase-name = "tondu-database"
  
 }

