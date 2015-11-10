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
    def self._exec (cmd='', opts='')
        # construct that terraform command
        tf_cmd = "#{$tf_bin} #{cmd} #{opts} #{TF_SRC_DIR}"

        # print the command before doing anything
        puts tf_cmd
        _setenv() # set those envs already!

        # execute the thing!
        if not system(tf_cmd)
            raise "Error executing Terraform!: #{$?}"
        end
    end

    def self._get_state_file()
       "#{TF_ENV_DIR}/#{TF_ENV}.tfstate" # state file
    end

    def self._get_var_file()
        "#{TF_ENV_DIR}/vars.tfvars" # variables file
    end

    # terraform get
    def self.get()
        _exec('get', '-update=true')
    end

    # terraform apply
    def self.apply ()
        _exec('apply', "-state=#{_get_state_file} -var-file=#{_get_var_file}")
    end

    # terraform plan
    def self.plan()
        _exec('plan', "-state=#{_get_state_file} -var-file=#{_get_var_file}")
    end

    # terraform destroy
    def self.destroy()
        _exec('destroy', "-state=#{_get_state_file} -var-file=#{_get_var_file}")
    end
end

