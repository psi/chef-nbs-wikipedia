node.set['mongodb']['cluster_name'] = 'nbs_wikipedia'
include_recipe 'mongodb'

wikipedia_data_file = "http://dumps.wikimedia.org/other/pagecounts-raw/2012/2012-01/pagecounts-20120101-000000.gz"

execute 'retrieve-wikipedia-data-file' do
  command "wget -O - #{wikipedia_data_file} | gzip -d > /tmp/pagecounts.csv"
  not_if { ::File.exists?("/tmp/pagecounts.csv") }
end
