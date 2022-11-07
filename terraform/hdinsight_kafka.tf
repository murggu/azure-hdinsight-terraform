resource "azurerm_hdinsight_kafka_cluster" "hdi_kafka" {
  name                = "kafka${local.safe_prefix}${local.safe_postfix}"
  resource_group_name = azurerm_resource_group.hdi_rg.name
  location            = azurerm_resource_group.hdi_rg.location
  cluster_version     = var.cluster_version
  tier                = var.tier

  component_version {
    kafka = var.component_version_kafka
  }

  gateway {
    username = var.gateway_username
    password = var.gateway_password
  }

  roles {
    head_node {
      vm_size            = var.roles_head_node_vm_size
      username           = var.ssh_username
      password           = var.ssh_password
      subnet_id          = azurerm_subnet.hdi_snet_default.id
      virtual_network_id = azurerm_virtual_network.hdi_vnet.id
    }

    worker_node {
      number_of_disks_per_node = var.roles_worker_node_number_of_disks_per_node
      vm_size                  = var.roles_worker_node_vm_size
      username                 = var.ssh_username
      password                 = var.ssh_password
      subnet_id                = azurerm_subnet.hdi_snet_default.id
      virtual_network_id       = azurerm_virtual_network.hdi_vnet.id
      target_instance_count    = var.roles_worker_node_target_instance_count
      #   autoscale {
      #     recurrence {
      #       timezone = "E. South America Standard Time"
      #       dynamic "schedule" {
      #         for_each = var.autoscale_schedules
      #         content {
      #           days                  = schedule.value.days
      #           time                  = schedule.value.time
      #           target_instance_count = schedule.value.target_instance_count
      #         }
      #       }
      #     }
      #   }
    }

    zookeeper_node {
      vm_size            = var.roles_zookeeper_node_vm_size
      username           = var.ssh_username
      password           = var.ssh_password
      subnet_id          = azurerm_subnet.hdi_snet_default.id
      virtual_network_id = azurerm_virtual_network.hdi_vnet.id
    }
  }

  # storage_account {
  #   storage_container_id = azurerm_storage_container.hdi_st_container[0].id
  #   storage_account_key  = azurerm_storage_account.hdi_st.primary_access_key
  #   is_default           = var.storage_account_is_default
  # }

  storage_account_gen2 {
    storage_resource_id          = azurerm_storage_account.hdi_st.id
    filesystem_id                = azurerm_storage_data_lake_gen2_filesystem.hdi_ws_adls[0].id
    is_default                   = var.storage_account_is_default
    managed_identity_resource_id = azurerm_user_assigned_identity.hdi_id.id
  }

  metastores {
    ambari {
      server        = join("", [azurerm_sql_server.hdi_sql.name, ".database.windows.net"])
      database_name = azurerm_sql_database.hdi_sqldb_metastore["ambari"].name
      username      = azurerm_sql_server.hdi_sql.administrator_login
      password      = azurerm_sql_server.hdi_sql.administrator_login_password
    }

    hive {
      server        = join("", [azurerm_sql_server.hdi_sql.name, ".database.windows.net"])
      database_name = azurerm_sql_database.hdi_sqldb_metastore["hive"].name
      username      = azurerm_sql_server.hdi_sql.administrator_login
      password      = azurerm_sql_server.hdi_sql.administrator_login_password
    }

    oozie {
      server        = join("", [azurerm_sql_server.hdi_sql.name, ".database.windows.net"])
      database_name = azurerm_sql_database.hdi_sqldb_metastore["oozie"].name
      username      = azurerm_sql_server.hdi_sql.administrator_login
      password      = azurerm_sql_server.hdi_sql.administrator_login_password
    }
  }

  count = var.enable_kafka_cluster ? 1 : 0

  tags = local.tags
}