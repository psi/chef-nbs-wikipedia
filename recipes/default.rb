#
# Cookbook Name:: nbs-wikipedia
# Recipe:: default
#
# Copyright (c) 2014 The Authors, All Rights Reserved.

include_recipe 'apt'
include_recipe 'nbs-wikipedia::mongodb'
include_recipe 'nbs-wikipedia::utils'
include_recipe 'nbs-wikipedia::data'
