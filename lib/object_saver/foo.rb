# frozen_string_literal: true

require 'byebug'
require_relative "bar"

# This is a class for tests
class Foo
  attr_accessor :bars
  def initialize(bars_size)
    @bars = []
    (1..bars_size.to_i).each do |i|
      @bars.push Bar.new("placeholder_#{i}")
    end
  end

  def Bar.create_from_object_saver
    block = lambda do |i|
    end

    total_params = instance_method(:initialize).parameters.map(&:last).size
    new(*Array.new(total_params, nil), &block)
  end
end
