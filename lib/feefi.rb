require "feefi/version"
require 'thor'

# dev gems
begin
  require 'pry'
rescue LoadError
end

module Feefi
  # Your code goes here...
  FEEFI_CONFIG_PATH = File.expand_path "~/.feefi"
  FEEFI_CONFIG_FILE = File.join(FEEFI_CONFIG_PATH,"feefi.yml")
end
