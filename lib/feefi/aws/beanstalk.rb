module Feefi::AWS
  class Beanstalk
    include Feefi::Helpers

    attr_accessor :aws, :config, :beanstalk_connection, :ec2_connection
    def initialize(aws,config)
      @aws = aws
      @beanstalk_connection = aws.beanstalk_connection
      @ec2_connection = aws.ec2_connection
      @config = config
    end
    
    # Obtains a list of configuration templates for the current beanstalk app
    def list_templates
      beanstalk_connection.templates.map(&:name)
    end
    
    def delete_template(name)
        beanstalk_connection.templates.get( @config.name, name).destroy
    end
    
    # gets the current EB OS Environment variables for the deployed app on a
    # current eb environment, overloaded term. eb environments are
    # arbitrary and are loosely similar to a Rails env. 
    def list_variables(eb_env_name)
      begin
        body = beanstalk_connection.describe_configuration_settings("ApplicationName" => @config.name, "EnvironmentName" => eb_env_name).body
        current_env_variables = body['DescribeConfigurationSettingsResult']['ConfigurationSettings'].first['OptionSettings'].select \
          {|ea| ea['Namespace'] == ENV_NAMESPACE}
      rescue Fog::AWS::ElasticBeanstalk::InvalidParameterError => e
        puts "An error occurred connecting to Beanstalk. Check your options!"
        puts e
        exit
      end
    end
    
    # List it out all environments for an application
    def environments
      beanstalk_connection.environments.map(&:name) 
    end

    def clone_environment(eb_env_name)
      env_to_clone = beanstalk_connection.environments.get eb_env_name
      #cloned_attr = %w(application_name solution_stack_name version_label)
      binding.pry
    end
    
    # Delete the oldest version(s) of code
    # This also deletes the source bundle on S3
    def cleanup_versions(pop = 1)
      versions_to_delete = versions.sort_by {|version| version.created_at}[range]
      versions_to_delete.each {|v| v.destroy(true)}
    end

    def versions
       beanstalk_connection.versions.sort_by {|version| version.created_at}
    end
    
    # Uses EC2 and the tags to get a list of EC2 instances associated with this app and Beanstalk environment
    # Technically the eb_env is merely a filter and will match using Array#include? in the env_env varianble.
    def servers(eb_env)
      @aws.ec2_connection.servers.select do |server|
        if server.tags && server.tags["elasticbeanstalk:environment-name"]
          server.tags["elasticbeanstalk:environment-name"].include? eb_env
        else
          nil
        end
      end
    end

  end
end
