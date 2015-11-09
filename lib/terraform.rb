#-*- mode: ruby -*-
# vi: set ft=ruby :

# Configuration library
require File.join(File.dirname(__FILE__), "lib/config.rb")

module Terraform
    def self.exec (args)
        %{ $terraform_bin }
    end

    def self.apply ()
        exec()
    end

    def self.plan()
        exec()
    end
end

