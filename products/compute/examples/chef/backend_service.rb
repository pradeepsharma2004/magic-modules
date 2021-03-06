<%# The license inside this block applies to this file
# Copyright 2017 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
-%>
<% unless name == 'README.md' -%>

<%= compile 'templates/license.erb' -%>

<%= lines(autogen_notice :chef) -%>

<%= compile 'templates/chef/example~auth.rb.erb' -%>

<% end -%>
<% if name == "README.md" -%>
# Backend Service requires various other services to be setup beforehand. Please
# make sure they are defined as well:
#   - gcompute_instance_group 'my-masters' do ... end
#   - Health check
<% else # name == README.md -%>
gcompute_instance_group <%= example_resource_name('my-masters') -%> do
  action :create
  zone 'us-central1-a'
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end

<% end # name == README.md -%>
gcompute_backend_service <%= example_resource_name('my-app-backend') -%> do
  action :create
  backends [
    { group: <%= example_resource_name('my-masters') -%> }
  ]
  enable_cdn true
  health_checks [
    gcompute_health_check_ref('another-hc', ENV['PROJECT']) # ex: 'my-test-project'
  ]
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end
