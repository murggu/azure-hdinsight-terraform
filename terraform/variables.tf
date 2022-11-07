variable "prefix" {
  type        = string
  description = "Prefix for module names"
}

resource "random_string" "postfix" {
  length  = 6
  special = false
  upper   = false
}

variable "location" {
  type        = string
  description = "Location for modules"
}

variable "cluster_version" {
  type        = string
  description = "Specifies the Version of HDInsights which should be used for this Cluster"
}

variable "component_version_hadoop" {
  type        = string
  description = "The version of Hadoop which should be used for this HDInsight Hadoop Cluster"
}

variable "component_version_hbase" {
  type        = string
  description = "The version of HBase which should be used for this HDInsight HBase Cluster"
}

variable "component_version_spark" {
  type        = string
  description = "The version of Spark which should be used for this HDInsight Spark Cluster"
}

variable "component_version_interactive" {
  type        = string
  description = "The version of Interactive which should be used for this HDInsight Interactive Cluster"
}

variable "component_version_kafka" {
  type        = string
  description = "The version of Kafka which should be used for this HDInsight Kafka Cluster"
}

variable "gateway_username" {
  type        = string
  description = "The username used for the Ambari Portal"
}

variable "gateway_password" {
  type        = string
  description = "The password used for the Ambari Portal"
  sensitive   = true
}

variable "ssh_username" {
  type        = string
  description = "The username used for the ssh"
}

variable "ssh_password" {
  type        = string
  description = "The password used for the ssh"
}

variable "roles_head_node_vm_size" {
  type        = string
  description = "The Size of the Virtual Machine which should be used as the Head Nodes"
}

variable "roles_worker_node_number_of_disks_per_node" {
  type        = number
  description = "The number of Data Disks which should be assigned to each Worker Node"
  default     = 1
}

variable "roles_worker_node_vm_size" {
  type        = string
  description = "The Size of the Virtual Machine which should be used as the Worker Nodes"
}

variable "roles_worker_node_target_instance_count" {
  type        = number
  description = "The number of instances which should be run for the Worker Nodes"
}

variable "roles_zookeeper_node_vm_size" {
  type        = string
  description = "The Size of the Virtual Machine which should be used as the Zookeeper Nodes"
}

variable "storage_account_is_default" {
  type        = bool
  description = "Is this the Default Storage Account for the HDInsight Cluster?"
  default     = true
}

variable "tier" {
  type        = string
  description = "Specifies the Tier which should be used for this HDInsight Cluster"
}

variable "metastore_sku" {
  type        = map(any)
  description = "SKUs to be used for each metastore"
  default = {
    ambari = "S0"
    hive   = "S0"
    oozie  = "S0"
  }
}

# variable "autoscale_schedules" {
#   type = list(object({
#     days                  = list(string)
#     time                  = string
#     target_instance_count = number
#   }))
# }

variable "enable_hadoop_cluster" {
  description = "Variable to enable or disable Hadoop cluster deployment"
  default     = false
}

variable "enable_spark_cluster" {
  description = "Variable to enable or disable Spark cluster deployment"
  default     = false
}

variable "enable_kafka_cluster" {
  description = "Variable to enable or disable Kafka cluster deployment"
  default     = false
}

variable "enable_interactive_cluster" {
  description = "Variable to enable or disable Interactive cluster deployment"
  default     = false
}

variable "enable_hbase_cluster" {
  description = "Variable to enable or disable HBase cluster deployment"
  default     = false
}

variable "enable_adls2" {
  description = "Variable to enable or disable ADLS Gen2"
  default     = false
}