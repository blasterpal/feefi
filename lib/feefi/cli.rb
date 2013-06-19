require 'feefi'
require 'feefi/config'
require 'feefi/setup'
require 'feefi/helpers'

class Feefi::Cli < Thor


  desc "setup", "Setup your feefi, creates ~/.feefi and writes config"
  def setup
    Feefi::Setup.create_feefi_config
  end

  desc "apps", "List apps"
  def apps
    Feefi::Helpers.preamble "Your apps"
    puts Feefi::Config.apps.map(&:name)
  end

  desc "servers", "List servers for EB app environment "
  def 
    #beanstalk = Feefi::AWS.new
    binding.pry
  end
end
