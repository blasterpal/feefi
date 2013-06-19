module Feefi
  class Setup
    class << self
      def create_feefi_config()
        puts "Setting up #{Feefi::FEEFI_CONFIG_FILE} ..."
        # does directory exist?
        unless Dir.exists? Feefi::FEEFI_CONFIG_PATH
          Dir.mkdir(Feefi::FEEFI_CONFIG_PATH) #unless
        end  
        
        if File.exist?(Feefi::FEEFI_CONFIG_FILE)
          puts "Config file: #{Feefi::FEEFI_CONFIG_FILE} already exists!"
        else
          content = 
            {:apps => [{
                  :name => 'my_beanstalk_app',
                  :beanstalk_config => {},
                  :aws_id => 'ASADFADFSDF',
                  :aws_secret => '!@#$!@#!@$',
                  :environments => ['staging','production']},
                  
              {
                  :name => 'my_beanstalk_app2',
                  :beanstalk_config => {},
                  :aws_id => 'ASADFADFSDF',
                  :aws_secret => '!@#$!@#!@$',
                  :environments => ['staging','production']}

              ]
              }.to_yaml
          File.open(Feefi::FEEFI_CONFIG_FILE,'w') do |f|
            f << content
          end
        end
      end
      def upsert_app(app_name,aws_id,aws_secret)
        
      end
      protected
      def read_config
        TOML.load_file(Feefi::FEEFI_CONFIG_FILE )
      end

      def write_config(config_hash)
        
      end
    end
  end
end
