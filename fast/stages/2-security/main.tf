/**
 * Copyright 2024 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

locals {
  has_env_folders = var.folder_ids.security-dev != null
  iam_delegated = join(",", formatlist("'%s'", [
    "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  ]))
  iam_admin_delegated = try(
    var.stage_configs["security"].iam_admin_delegated, {}
  )
  iam_viewer = try(
    var.stage_configs["security"].iam_viewer, {}
  )
  project_services = [
    "certificatemanager.googleapis.com",
    "cloudkms.googleapis.com",
    # "networkmanagement.googleapis.com",
    # "networksecurity.googleapis.com",
    "privateca.googleapis.com",
    "secretmanager.googleapis.com",
    "stackdriver.googleapis.com"
  ]
}

module "folder" {
  source        = "../../../modules/folder"
  folder_create = false
  id            = var.folder_ids.security
  contacts = (
    var.essential_contacts == null
    ? {}
    : { (var.essential_contacts) = ["ALL"] }
  )
}

module "project" {
  source   = "../../../modules/project"
  for_each = var.environments
  name     = "${each.value.short_name}-sec-core-0"
  parent = coalesce(
    var.folder_ids["security-${each.key}"], var.folder_ids.security
  )
  prefix          = var.prefix
  billing_account = var.billing_account.id
  labels          = { environment = each.key }
  services        = local.project_services
  tag_bindings = local.has_env_folders ? {} : {
    environment = var.tag_values["environment/${each.value.tag_name}"]
  }
  # optionally delegate a fixed set of IAM roles to selected principals
  iam = {
    "roles/iam.securityReviewer" = try(
      local.iam_viewer[each.key], []
    )
  }
  iam_bindings = (
    lookup(local.iam_admin_delegated, each.key, null) == null ? {} : {
      sa_delegated_grants = {
        role    = "roles/cloudkms.admin"
        members = try(local.iam_admin_delegated[each.key], [])
        condition = {
          title       = "${each.key}_stage3_sa_delegated_grants"
          description = "${var.environments[each.key].name} KMS delegated grants."
          expression = format(
            "api.getAttribute('iam.googleapis.com/modifiedGrantsByRole', []).hasOnly([%s])",
            local.iam_delegated
          )
        }
      }
    }
  )
}
