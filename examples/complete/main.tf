provider "intersight" {
  apikey    = var.apikey
  secretkey = var.secretkey
  endpoint  = var.endpoint
}

module "terraform-intersight-iks" {
  source = "terraform-cisco-modules/iks/intersight"
  # source = "terraform-cisco-modules/iks/intersight//"
  # Infra Config Policy Information
  cluster_name = "POC"
  # cluster_action   = "Deploy"
  vc_target_name   = "11.11.11.80"
  vc_portgroup     = ["Terraform-50"]
  vc_datastore     = "Terraform"
  vc_cluster       = "HX"
  vc_resource_pool = ""
  vc_password      = var.vc_password

  # IP Pool Information
  ip_starting_address = "192.168.70.100"
  ip_pool_size        = "20"
  ip_netmask          = "255.255.255.0"
  ip_gateway          = "192.168.70.1"
  ntp_servers         = ["pool.time.org"]
  dns_servers         = ["8.8.8.8"]

  addons_list = [{
    addon_policy_name = "dashboard"
    addon             = "kubernetes-dashboard"
    description       = "K8s Dashboard Policy"
    upgrade_strategy  = "AlwaysReinstall"
    install_strategy  = "InstallOnly"
    },
    {
      addon_policy_name = "monitor"
      addon             = "ccp-monitor"
      description       = "Grafana Policy"
      upgrade_strategy  = "AlwaysReinstall"
      install_strategy  = "InstallOnly"
    }
  ]
  # Network Configuration Settings
  # pod_cidr = "100.65.0.0/16"
  # service_cidr = "100.64.0.0/24"
  # cni = "Calico"
  domain_name = "nterone.com"
  timezone    = "America/New_York"


  # Trusted Registry Entry
  # unsigned_registries = ["10.101.128.128"]
  # root_ca_registries  = [""]

  # Cluster information
  ssh_user       = var.ssh_user
  ssh_key        = var.ssh_key
  worker_size    = "medium"
  worker_count   = 4
  master_count   = 1
  load_balancers = 3
  # Organization and Tag
  organization = var.organization
  tags         = var.tags
}


