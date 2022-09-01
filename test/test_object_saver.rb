# frozen_string_literal: true

require "byebug"
require "test_helper"
require "./lib/object_saver/bar"
require "./lib/object_saver"

class TestObjectSaver < Minitest::Test
  def test_initialize
    assert_equal(ObjectSaver.new("test/test.json"),
                 ObjectSaver.new("test/test.json"))

    expection = assert_raises StandardError do
      ObjectSaver.new(nil)
    end

    assert_equal("{:file_path=>[\"can not be blank\"]}", expection.message)

    expection = assert_raises StandardError do
      ObjectSaver.new("unknown_file/")
    end

    assert_equal("{:file_path=>[\"File does not exist, please create and try again\"]}", expection.message)
  end

  def test_that_can_dismember_an_entire_object
    object_saver = ObjectSaver.new "test/test.json"

    assert_equal(object_saver.dismember_object(Bar.new("variable", "test")), {
                   bar_object: {
                     placeholder: "variable",
                     optional: "test"
                   }
                 })
  end

  def test_that_can_save_an_object
    object_saver = ObjectSaver.new "test/test.json"
    bar = Bar.new("variable")

    assert_equal(object_saver.save(bar), true)
  end

  def test_that_can_load_an_object
    object_saver = ObjectSaver.new "test/test.json"
    bar = Bar.new("variable")
    object_saver.save(bar)

    assert_equal(object_saver.load, Bar.new("variable"))
  end
end
