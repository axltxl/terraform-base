#-*- mode: ruby -*-
# vi: set ft=ruby :

# Configuration library
require File.join(File.dirname(__FILE__), "config.rb")

module Terraform
    def self._exec (args='')
        cmd = "#{$terraform_bin} #{args}"
        puts cmd
        if not system(cmd)
            raise "Error executing Terraform!: #{$?}"
        end
    end

    def self.apply ()
        _exec('apply')
    end

    def self.plan()
        _exec('plan')
    end
end

