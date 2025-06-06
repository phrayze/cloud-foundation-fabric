/**
 * Copyright 2025 Google LLC
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

output "instance_addresses" {
  description = "Instance names and addresses."
  value = {
    for k, v in module.instances : k => v.internal_ip
  }
}

output "instance_ssh" {
  description = "Instance SSH commands."
  value = {
    for k, v in module.instances : k => (
      "gcloud compute ssh ${k} --project ${v.instance.project} --zone ${v.instance.zone}"
    )
  }
}

output "service_account_emails" {
  description = "Service account emails."
  value = {
    for k, v in module.service-accounts : k => v.email
  }
}
