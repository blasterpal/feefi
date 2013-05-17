require 'feefi'

class Feefi::Cli < Thor
  desc "hello", "says hello"
  def hello
    say "hello!"
  end
end
