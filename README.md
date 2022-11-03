# azure-hdinsight-terraform

This repo shows an example for rolling out a complete HDInsight environment (inbound) via Terraform.

This includes rollout of the following resources:

- HDInsight Cluster
- Azure Storage Account
- Virtual Network including a default subnet
- Azure SQL Database for Ambari, Oozie and Hive metastores

## Instructions

Make sure you have the [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli) and [Terraform](https://www.terraform.io/downloads.html) installed. 

1. Go to `terraform` folder
2. Copy `terraform.tfvars.example` to `terraform.tfvars`
3. Update `terraform.tfvars` with your desired values
4. Run Terraform
    ```console
    $ terraform init
    $ terraform plan
    $ terraform apply
    ```
    
## Notes
See notes below for additional info:

- Change `enable_hadoop_cluster`, `enable_spark_cluster`, `enable_kafka_cluster`, `enable_interactive_cluster` or `enable_hbase_cluster` values to deploy any of those clusters.
- Cluster creation can take between 20-40min.
- The deployment was tested on wsl (ubuntu).
