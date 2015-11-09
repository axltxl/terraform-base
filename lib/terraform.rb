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
        $tf_vars.each do |key, value|
            ENV["TF_VAR_#{key}"] = value
        end

        # Environment as tf variable
        ENV['TF_VAR_environment'] = TF_ENV

        # Terraform wants logs
        ENV['TF_LOG'] = 'TRACE'
        ENV['TF_LOG_PATH'] = File.absolute_path(File.join(File.dirname(__FILE__), "../tf.log"))
    end

    # raw execution of terraform
    def self._exec (args='')
        # construct that terraform command
        cmd = "#{$tf_bin} #{args} #{TF_SRC_DIR}"

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

