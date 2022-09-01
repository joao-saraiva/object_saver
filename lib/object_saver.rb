# frozen_string_literal: true

require "object_saver/object_saver_validator"

# This object should be able to save an object into a json and read it
class ObjectSaver
  attr_accessor :directory

  def initialize(directory)
    @directory = directory
    errors = ObjectSaverValidator.new.validate(self)

    raise StandardError.new errors.to_s if errors.any? 
  end

  def dismember_object(object, *args)
    instances_to_save = args.any? ? args : object.instance_variables
    object_key = "#{object.class.name.downcase}_object".to_sym
    hashed_object = {}
    hashed_object[object_key] = {}

    instances_to_save.each do |instance|
      formated_instance = instance.to_s.tr("@", "")
      hashed_object[object_key][formated_instance.to_sym] = object.send(formated_instance)
    end

    hashed_object
  end

  def ==(object)
    directory = object.directory
  end
end
