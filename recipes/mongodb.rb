# Use the vendor's repo so we get a modern version of MongoDB
include_recipe 'mongodb::mongodb_org_repo'

node.set['mongodb']['dbconfig_file'] = '/etc/mongod.conf'
include_recipe 'mongodb'

# Override the config file template and change the location due to
# using a newer version

r = resources(template: node['mongodb']['dbconfig_file'])
r.cookbook 'nbs-wikipedia'
r.source 'mongod.conf.erb'
r.notifies :restart, 'service[mongodb]'

wikipedia_data_file = "http://dumps.wikimedia.org/other/pagecounts-raw/2012/2012-01/pagecounts-20120101-000000.gz"

execute 'retrieve-wikipedia-data-file' do
  command "wget -O - #{wikipedia_data_file} | gzip -d > /tmp/pagecounts.csv"
  not_if { ::File.exists?("/tmp/pagecounts.csv") }
end
