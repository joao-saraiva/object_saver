# frozen_string_literal: true

require "test_helper"
require "./lib/object_saver/foo"
require "byebug"

class TestFoo < Minitest::Test
  def test_initialize
    foo = Foo.new(5)

    assert_equal foo.bars.size, 5
  end
end
