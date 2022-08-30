# frozen_string_literal: true

require_relative "bar"

# This is a class for tests
class Foo
  attr_accessor :bars

  def initialize(bars_size)
    @bars = []
    (1..bars_size).each do |i|
      @bars.push Bar.new("placeholder_#{i}")
    end
  end
end
