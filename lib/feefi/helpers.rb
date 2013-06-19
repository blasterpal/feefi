module Feefi
  module Helpers
      def preamble(message)
        puts "#{message}"
        puts "-----------"
      end
      # presumed to be used within method
      def app_config
        Feefi::Config.app_config options[:app]
      end
  end
end
