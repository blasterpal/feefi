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
  method_option :app, :type => :string, :required => true
  method_option :env, :type => :string, :required => true
  def servers
    s = beanstalk.servers options[:env]
  end

  desc "templates", "list templates, to delete a template: --delete --name <template_name>"
  method_option :app, :type => :string, :required => true
  method_option :delete, :type => :boolean
  method_option :name, :type => :string
  def templates
    if options[:delete]
      if yes? "Are you sure you want to delete #{options[:name]}?"
        beanstalk.delete_template options[:name]
      end
    else
      preamble "#{options[:app]} | #{options[:env]} Configuration Templates"
      puts beanstalk.list_templates
    end
  end

  desc "environments", "List application environments"
  method_option :app, :type => :string, :required => true
  method_option :list, :type => :boolean
  def environments
    if options[:list]
      preamble "#{options[:app]} environments"
      puts beanstalk.environments
    end
  end

  desc "Manage versions", "List and cleanup versions, to delete --delete --count <num of old releases>"
  method_option :app, :type => :string, :required => true
  method_option :count, :type => :numeric
  method_option :delete, :type => :boolean
  def versions
    unless options[:list] || options[:delete]
      puts "No action specified, supply --list or --delete"
      exit
    end
    if options[:delete]
      count = options[:count].to_i
      if yes? "Are you sure you want to delete #{options[:count] || 1} versions?"
        beanstalk.cleanup_versions options[:count]
      end
    else options[:list]
      preamble "Printing application versions..." 
      versions = beanstalk.versions
      puts versions.collect {|ea| "#{ea.created_at} | #{ea.label} | #{ea.description}" }
      puts "--------"
      puts "Count: #{versions.size}"
    end
  end

  desc "beanstalk connection", "Drop you into pry and let you mess around"
  method_option :app, :type => :string, :required => true
  def repl
    beanstalk
    puts "Access the method 'beanstalk' for fun..."
    Pry.start self, :quiet => true
  end

  protected
  def connection
    @connection ||= Feefi::AWS::Connection.new app_config
  end

  def beanstalk
    @beanstalk ||= Feefi::AWS::Beanstalk.new connection, app_config
  end

end
