require 'fog'
module Feefi
  class AWS
    ENV_NAMESPACE = 'aws:elasticbeanstalk:application:environment'
    attr_accessor :aws_id, :aws_key, :app_name
    def initialize(aws_id,aws_key,app_name)
      @aws_id = aws_id
      @aws_key = aws_key
      @app_name = app_name  
    end

    def connection 
      Fog::Compute.new({:provider => 'AWS', :aws_access_key_id => @aws_id, :aws_secret_access_key => @aws_key })
    end

    def servers(eb_env)
      compute.servers.select do |server|
        server.tags["elasticbeanstalk:environment-name"]  == @app_name
      end
    end
    
    # gets the current EB OS Environment variables for the deployed app on a
    # current eb environment, overloaded term. eb environments are
    # arbitrary and are loosely similar to a Rails env. 
    def env_variables(eb_env_name)
      begin
        body = connection.describe_configuration_settings("ApplicationName" => @app_name, "EnvironmentName" => eb_env_name).body
        current_env_variables = body['DescribeConfigurationSettingsResult']['ConfigurationSettings'].first['OptionSettings'].select \
          {|ea| ea['Namespace'] == ENV_NAMESPACE}
      rescue Fog::AWS::ElasticBeanstalk::InvalidParameterError => e
        puts "An error occurred connecting to Beanstalk. Check your options!"
        puts e
        exit
      end
    end

    def eb_environments
      binding.pry 
    end

  end
end
