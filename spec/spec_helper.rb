require "rspec"
require "pry"

Encoding.default_external = Encoding::UTF_8

$LOAD_PATH.unshift File.expand_path("lib", __dir__)

Dir[File.expand_path("support/**/*.rb", __dir__)].each do |f|
  require f
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end

class String
  def inspect
    self.to_s
  end
end
