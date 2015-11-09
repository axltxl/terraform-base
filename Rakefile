#-*- mode: ruby -*-
# vi: set ft=ruby :

# Configuration library
require File.join(File.dirname(__FILE__), "lib/config.rb")

# Terraform helper library
require File.join(File.dirname(__FILE__), "lib/terraform.rb")


##################
# The actual tasks
##################

desc 'run terraform plan on project'
task 'plan' do
    Terraform.plan()
end

desc 'run terraform apply on project'
task 'apply' do
    Terraform.apply()
end

desc 'run terraform destroy on project'
task 'destroy' do
    Terraform.destroy()
end
