# -*- mode: ruby -*-
# # vi: set ft=ruby :

# Version control-related variables
require File.join(File.dirname(__FILE__), "git.rb")

# Configuration file location
CONFIG = File.join(File.dirname(__FILE__), "../config.rb")


###################################
## git branch as an terraform environment
####################################
TERRAFORM_ENV = Git::BRANCH

# Defaults for terraform
$terraform_bin = "terraform"

# Import configuration file (if any)
if File.exist?(CONFIG)
    require CONFIG
end
