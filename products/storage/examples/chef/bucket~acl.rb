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
<% unless name == "README.md" -%>
<%= compile 'templates/license.erb' -%>

<%= lines(autogen_notice :chef) -%>

<%= compile 'templates/chef/example~auth.rb.erb' -%>

<% end # name == README.md -%>
gstorage_bucket <%= example_resource_name('storage-module-test') -%> do
  action :create
  acl [
    {
      entity: 'user-nelsona@google.com',
      role: 'OWNER'
    },
    {
      entity: 'allAuthenticatedUsers',
      role: 'READER'
    },
    {
      entity: 'project-owners-1068887641754',
      role: 'OWNER'
    }
  ]
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end
