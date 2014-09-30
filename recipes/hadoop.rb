include_recipe 'nbs-wikipedia::java'

# Start a namenode
include_recipe 'hadoop::hadoop_hdfs_namenode'

ruby_block 'format-hdfs-namenode' do
  block do
    resources('execute[hdfs-namenode-format]').run_action(:run)
  end
end

ruby_block 'service-hadoop-hdfs-namenode-start' do
  [:start, :enable].each do |action|
    block do
      resources('service[hadoop-hdfs-namenode]').run_action(action)
    end
  end
end

# Start a datanode
include_recipe 'hadoop::hadoop_hdfs_datanode'

ruby_block 'service-hadoop-hdfs-datanode-start' do
  [:start, :enable].each do |action|
    block do
      resources('service[hadoop-hdfs-datanode]').run_action(action)
    end
  end
end
