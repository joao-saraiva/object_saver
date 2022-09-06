# frozen_string_literal: true

# This is a class for tests
class Bar
  attr_accessor :placeholder, :optional

  def initialize(placeholder, optional = nil)
    @optional = optional
    @placeholder = placeholder
  end

  def ==(other)
    placeholder == other.placeholder
  end

  def Bar.create_from_object_saver
    block = lambda do |i|
    end

    total_params = instance_method(:initialize).parameters.map(&:last).size
    new(*Array.new(total_params, nil), &block)
  end
end
