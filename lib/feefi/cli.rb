require 'feefi'
require 'feefi/config'
require 'feefi/setup'
require 'feefi/helpers'
require 'feefi/aws/connection'
require 'feefi/aws/beanstalk'


class Feefi::Cli < Thor

  include Feefi::Helpers 
  include Thor::Actions

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
      preamble "#{options[:app_name]} | #{options[:env]} Configuration Templates"
      puts beanstalk.list_templates
    elsif options[:delete]
      if yes? "Are you sure you want to delete #{options[:name]}?"
          beanstalk.delete_template options[:name]
      end
    end
  end

  private
  def connection
    @connection ||= Feefi::AWS::Connection.new app_config
  end

  def beanstalk
    @beanstalk ||= Feefi::AWS::Beanstalk.new connection, app_config
  end

end
