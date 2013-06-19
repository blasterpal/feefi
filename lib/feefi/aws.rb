require 'fog'
module Feefi
  class AWS
    ENV_NAMESPACE = 'aws:elasticbeanstalk:application:environment'
    attr_accessor :config, :ec2_connection, :beanstalk_connection
    def initialize(config)
      @config = config
      @ec2_connection = Fog::Compute.new({:provider => 'AWS', 
          :aws_access_key_id => @config.aws_id, 
          :aws_secret_access_key => @config.aws_secret }) 
      @beanstalk_connection = Fog::AWS::ElasticBeanstalk.new({
          :aws_access_key_id => @config.aws_id,
          :aws_secret_access_key => @config.aws_secret })
    end

    # Uses EC2 and the tags to get a list of EC2 instances associated with this app and Beanstalk environment
    # Technically the eb_env is merely a filter and will match using Array#include? in the env_env varianble.
    def servers(eb_env)
      @ec2_connection.servers.select do |server|
        if server.tags && server.tags["elasticbeanstalk:environment-name"]
          server.tags["elasticbeanstalk:environment-name"].include? eb_env
        else
          nil
        end
      end
    end
    
    # gets the current EB OS Environment variables for the deployed app on a
    # current eb environment, overloaded term. eb environments are
    # arbitrary and are loosely similar to a Rails env. 
    def env_variables(eb_env_name)
      begin
        body = @beanstalk_connection.describe_configuration_settings("ApplicationName" => @config.name, "EnvironmentName" => eb_env_name).body
        current_env_variables = body['DescribeConfigurationSettingsResult']['ConfigurationSettings'].first['OptionSettings'].select \
          {|ea| ea['Namespace'] == ENV_NAMESPACE}
      rescue Fog::AWS::ElasticBeanstalk::InvalidParameterError => e
        puts "An error occurred connecting to Beanstalk. Check your options!"
        puts e
        exit
      end
    end
  
    # Obtains a list of configuration templates for the current beanstalk app
    def configuration_templates
      @beanstalk_connection.describe_applications.body['DescribeApplicationsResult']['Applications'].first['ConfigurationTemplates']
    end

    def eb_environments
      binding.pry 
    end

  end
end
