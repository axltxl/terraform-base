#-*- mode: ruby -*-
# vi: set ft=ruby :

# Configuration library
require File.join(File.dirname(__FILE__), "config.rb")

#######################
# Terraform as a module
#######################
module Terraform

    # Inject dynamic variables into Terraform
    def self._setenv(*args)
        # set user environment variables
        $terraform_vars.each do |key, value|
            ENV["TF_VAR_#{key}"] = value
        end

        # Environment as terraform variable
        ENV['TF_VAR_environment'] = TERRAFORM_ENV
    end

    # raw execution of terraform
    def self._exec (args='')
        # construct that terraform command
        cmd = "#{$terraform_bin} #{args}"

        # print the command before doing anything
        puts cmd
        _setenv() # set those envs already!

        # execute the thing!
        if not system(cmd)
            raise "Error executing Terraform!: #{$?}"
        end
    end

    # terraform apply
    def self.apply ()
        _exec('apply')
    end

    # terraform plan
    def self.plan()
        _exec('plan')
    end
end

