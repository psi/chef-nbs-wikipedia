# Use 10gen's repo so we get a modern version of MongoDB
include_recipe 'mongodb::10gen_repo'

# Override the config file template and change the location due to
# using a newer version
node.set['mongodb']['dbconfig_file']     = '/etc/mongod.conf'
node.set['mongodb']['template_cookbook'] = 'nbs-wikipedia'
node.set['mongodb']['dbconfig_file_template'] = 'mongod.conf.erb'

include_recipe 'mongodb'

wikipedia_data_file = "http://dumps.wikimedia.org/other/pagecounts-raw/2012/2012-01/pagecounts-20120101-000000.gz"

execute 'retrieve-wikipedia-data-file' do
  command "wget -O - #{wikipedia_data_file} | gzip -d > /tmp/pagecounts.csv"
  not_if { ::File.exists?("/tmp/pagecounts.csv") }
end
