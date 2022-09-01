# frozen_string_literal: true

require "byebug"
require "test_helper"
require "./lib/object_saver/foo"
require "./lib/object_saver/bar"
require "./lib/object_saver"

class TestObjectSaver < Minitest::Test
  def test_initialize
    assert_equal(ObjectSaver.new(__dir__),
                 ObjectSaver.new(__dir__))

    expection = assert_raises StandardError do
      ObjectSaver.new(nil)
    end

    assert_equal("{:directory=>[\"can not be blank\"]}", expection.message)

    expection = assert_raises StandardError do
      ObjectSaver.new("unknown_path/")
    end

    assert_equal("{:directory=>[\"directory does not exist in your system\"]}", expection.message)
  end

  def test_that_can_dismember_an_entire_object
    object_saver = ObjectSaver.new __dir__

    assert_equal(object_saver.dismember_object(Bar.new("variable")), {
                   bar_object: {
                     placeholder: "variable"
                   }
                 })
  end
end
