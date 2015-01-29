require 'yaml'

class Test
  attr_accessor :name
end

my = Test.new
my.name = 'Dave'
you = Test.new
you.name = 'You'

puts YAML::dump([my, you])