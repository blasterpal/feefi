require 'yaml'
require 'hashie'
module Feefi
  class Config
    class << self
      attr_accessor :config
      def method_missing(method_name)
        config.send method_name.to_sym
      end
    end
  end
end
