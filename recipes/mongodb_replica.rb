include_recipe 'apt'

node.set['mongodb']['cluster_name'] = 'nbs_wikipedia'
include_recipe 'mongodb::replicaset'
