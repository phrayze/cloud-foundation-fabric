# Terraform modules suite for Google Cloud

The modules collected in this folder are designed as a suite: they are meant to be composed together, and are designed to be forked and modified where use of third party code and sources is not allowed.

Modules try to stay close to the low level provider resources they encapsulate, and they all share a similar interface that combines management of one resource or set or resources, and the corresponding IAM bindings.

Authoritative IAM bindings are primarily used (e.g. `google_storage_bucket_iam_binding` for GCS buckets) so that each module is authoritative for specific roles on the resources it manages, and can neutralize or reconcile IAM changes made elsewhere.

Specific modules also offer support for non-authoritative bindings (e.g. `google_storage_bucket_iam_member` for service accounts), to allow granular permission management on resources that they don't manage directly.

These modules are not necessarily backward compatible. Changes breaking compatibility in modules are marked by major releases (but not all major releases contain breaking changes). Please be mindful when upgrading Fabric modules in existing Terraform setups, and always try to use versioned references in module sources so you can easily revert back to a previous version. Since the introduction of the `moved` block in Terraform we try to use it whenever possible to make updates non-breaking, but that does not cover all changes we might need to make.

These modules are used in the examples included in this repository. If you are using any of those examples in your own Terraform configuration, make sure that you are using the same version for all the modules, and switch module sources to GitHub format using references. The recommended approach to working with Fabric modules is the following:

- Fork the repository and own the fork. This will allow you to:
  - Evolve the existing modules.
  - Create your own modules.
  - Sync from the upstream repository to get all the updates.

- Use GitHub sources with refs to reference the modules. See an example below:

    ```terraform
    module "project" {
        source              = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/project?ref=v35.0.0&depth=1"
        name                = "my-project"
        billing_account     = "123456-123456-123456"
        parent              = "organizations/123456"
    }
    ```

## Foundational modules

- [Billing account](./billing-account)
- [Cloud Identity group](./cloud-identity-group/)
- [Folder](./folder)
- [Service accounts](./iam-service-account)
- [Logging bucket](./logging-bucket)
- [Organization](./organization)
- [Project](./project)
- [Projects (data source)](./projects-data-source)

## Process factories

- [Project factory](./project-factory/)

## Networking modules

- [Address reservation](./net-address)
- [Cloud Endpoints](./endpoints)
- [DNS](./dns)
- [DNS Response Policy](./dns-response-policy/)
- [Firewall policy](./net-firewall-policy)
- [External Application Load Balancer](./net-lb-app-ext/)
- [External Passthrough Network Load Balancer](./net-lb-ext)
- [External Regional Application Load Balancer](./net-lb-app-ext-regional/)
- [Internal Application Load Balancer](./net-lb-app-int)
- [Cross-region Internal Application Load Balancer](./net-lb-app-int-cross-region)
- [Internal Passthrough Network Load Balancer](./net-lb-int)
- [Internal Proxy Network Load Balancer](./net-lb-proxy-int)
- [NAT](./net-cloudnat)
- [Service Directory](./service-directory)
- [VPC](./net-vpc)
- [VPC factory](./net-vpc-factory)
- [VPC firewall](./net-vpc-firewall)
- [VPN dynamic](./net-vpn-dynamic)
- [VPC peering](./net-vpc-peering)
- [VPN HA](./net-vpn-ha)
- [VPN static](./net-vpn-static)

## Compute/Container

- [VM/VM group](./compute-vm)
- [MIG](./compute-mig)
- [COS container](./cloud-config-container/cos-generic-metadata/) (coredns/mysql/nva/onprem/squid)
- [GKE autopilot cluster](./gke-cluster-autopilot)
- [GKE standard cluster](./gke-cluster-standard)
- [GKE hub](./gke-hub)
- [GKE nodepool](./gke-nodepool)
- [GCVE private cloud](./gcve-private-cloud)

## Data

- [AlloyDB](./alloydb)
- [Analytics Hub](./analytics-hub)
- [BigQuery dataset](./bigquery-dataset)
- [Bigtable instance](./bigtable-instance)
- [Biglake catalog](./biglake-catalog)
- [Cloud SQL instance](./cloudsql-instance)
- [Data Catalog Policy Tag](./data-catalog-policy-tag)
- [Data Catalog Tag](./data-catalog-tag)
- [Data Catalog Tag Template](./data-catalog-tag-template)
- [Dataform Repository](./dataform-repository/)
- [Datafusion](./datafusion)
- [Dataplex](./dataplex)
- [Dataplex Aspect Types](./dataplex-aspect-types/)
- [Dataplex DataScan](./dataplex-datascan/)
- [Dataproc](./dataproc)
- [Firestore](./firestore)
- [GCS](./gcs)
- [Looker Core](./looker-core)
- [Pub/Sub](./pubsub)
- [Spanner instance](./spanner-instance)

## AI

- [AI Applications](./ai-applications/README.md)

## Development

- [API Gateway](./api-gateway)
- [Apigee](./apigee)
- [Artifact Registry](./artifact-registry)
- [Container Registry](./container-registry)
- [Cloud Source Repository](./source-repository)
- [Cloud Deploy](./cloud-deploy)
- [Secure Source Manager instance](./secure-source-manager-instance)
- [Workstation cluster](./workstation-cluster)

## Security

- [Binauthz](./binauthz/)
- [Certificate Authority Service (CAS)](./certificate-authority-service)
- [KMS](./kms)
- [SecretManager](./secret-manager)
- [VPC Service Control](./vpc-sc)
- [Secure Web Proxy](./net-swp)
- [Certificate Manager](./certificate-manager)

## Serverless

- [Cloud Functions v1](./cloud-function-v1)
- [Cloud Functions v2](./cloud-function-v2)
- [Cloud Run](./cloud-run)
- [Cloud Run v2](./cloud-run-v2)
