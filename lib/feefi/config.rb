require 'yaml'
require 'hashie'
module Feefi
  class Config
    class << self
      attr_accessor :config
      def app_config(app_name)
        config.apps.select {|ea| ea.name == app_name}.first
      end
      def method_missing(method_name)
        config.send method_name.to_sym
      end
    end
  end
end
