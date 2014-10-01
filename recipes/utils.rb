include_recipe 'ark'

ark 'nbs-wikipedia-utils' do
  url 'https://github.com/psi/nbs-wikipedia/releases/download/v1.0/nbs-wikipedia.tar.gz'
  action :put
end

%w(importer reporter).each do |cmd|
  link "/usr/local/bin/nbs-wikipedia-#{cmd}" do
    to "/usr/local/nbs-wikipedia-utils/nbs-wikipedia-#{cmd}"
  end
end
