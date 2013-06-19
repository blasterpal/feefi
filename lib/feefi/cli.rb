require 'feefi'
require 'feefi/aws'
require 'feefi/config'
require 'feefi/setup'
require 'feefi/helpers'

class Feefi::Cli < Thor

  include Feefi::Helpers 

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
  method_option :app_name, :type => :string, :required => true
  method_option :env, :type => :string, :required => true
  def servers
    beanstalk = Feefi::AWS.new app_config
    s = beanstalk.servers options[:env]
  end

  desc "manage configurations templates", "Manage saved configuration templates for an app and environment"
  method_option :app_name, :type => :string, :required => true
  method_option :env, :type => :string, :required => true
  method_option :list, :type => :boolean
  method_option :delete, :type => :boolean
  method_option :name, :type => :string
  def templates
    unless options[:list] || options[:delete]
      puts "No action specified, supply --list or --delete"
      exit
    end
    if options[:list]
      aws = Feefi::AWS.new app_config
      preamble "#{options[:app_name]} | #{options[:env]} Configuration Templates"
      puts aws.configuration_templates
    elsif options[:delete]

    end

  end

end
