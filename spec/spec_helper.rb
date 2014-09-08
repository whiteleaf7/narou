require 'rspec'

Dir["./support/**/*.rb"].each do |f|
  require f
end

#RSpec.configure do |config|
#end

class String
  def inspect
    self.to_s
  end
end

Encoding.default_external = Encoding::UTF_8
