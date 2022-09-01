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
end
