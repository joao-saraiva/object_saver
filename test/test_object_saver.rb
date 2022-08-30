# frozen_string_literal: true

require "byebug"
require "test_helper"
require "./lib/object_saver/foo"
require "./lib/object_saver/bar"
require "./lib/object_saver"

class TestObjectSaver < Minitest::Test
  def test_that_can_dismember_an_entire_object
    object_saver = ObjectSaver.new

    assert_equal(object_saver.dismember_object(Bar.new("variable")), {
                   bar_object: {
                     placeholder: "variable"
                   }
                 })
  end
end
