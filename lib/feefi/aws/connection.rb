require 'fog'
module Feefi::AWS
  class Connection
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
  end
end
