# A better idea is probably to nuke this recipe and make the importer take an
# arg that could potentially be a local file or a URL.
wikipedia_data_file = "http://dumps.wikimedia.org/other/pagecounts-raw/2012/2012-01/pagecounts-20120101-000000.gz"

execute 'retrieve-wikipedia-data-file' do
  command "wget -O - #{wikipedia_data_file} | gzip -d > /tmp/pagecounts.csv"
  not_if { ::File.exists?("/tmp/pagecounts.csv") }
end
