# frozen_string_literal: true

require "byebug"

# Loading all classes
Dir.glob("lib/object_saver/*.rb").map { |i| i.gsub("lib/", "") }.each { |f| require f if f != "lib/object_saver.rb" }

require "json"

# This object should be able to save an object into a json and read it
class ObjectSaver
  attr_accessor :file_path
  PRIMITIVE_TYPES = [Float, Integer, TrueClass, FalseClass, Float, String, Hash, Array, NilClass]

  def initialize(file_path)
    @file_path = file_path
    errors = ObjectSaverValidator.new.validate(self)

    raise StandardError, errors.to_s if errors.any?
  end

  def dismember_object(object, *args)
    instances_to_save = args.any? ? args : object.instance_variables
    object_key = "#{object.class.name.downcase}_object".to_sym
    hashed_object = {}
    hashed_object[object_key] = {}

    instances_to_save.each do |instance|
      formated_instance = instance.to_s.tr("@", "")
      hashed_object[object_key][formated_instance.to_sym] = formated_instance_value(object, formated_instance)
    end

    hashed_object
  end

  def formated_instance_value(object, formated_instance)
    values = object.send(formated_instance)
    objects_instances = values.kind_of?(Array) ? values.map { |v| v.class }.uniq : [values.class]

    return object.send(formated_instance) if (PRIMITIVE_TYPES & objects_instances).any?

    hashed_object = {}
    values.each_with_index do |value, index|
      object_key = "#{value.class.name.downcase}_object#{index + 1}".to_sym
      hashed_object[object_key] = {}

      value.instance_variables.each do |instance|
        formated_instance = instance.to_s.tr("@", "")
        hashed_object[object_key][formated_instance.to_sym] = value.send(formated_instance)
      end
    end

    hashed_object
  end

  def ==(other)
    file_path == other.file_path
  end

  def save(object)
    hashed_object = dismember_object(object)

    File.open(file_path, "w") do |file|
      file.write(hashed_object.to_json)
      return true
    rescue StandardError => e
      raise StandardError, e.message
    else
    end
  end

  def load
    file = JSON.parse(File.read(file_path))
    primary_object_key = file.keys.first
    object_name = primary_object_key.gsub("_object", "").capitalize
    meta_object = (Object.const_get object_name)
    meta_params_orders = meta_object.instance_method(:initialize).parameters.map(&:last).map(&:to_s)

    created_object = meta_object.create_from_object_saver()

    file[primary_object_key].keys.each do |key|
      created_object.send("#{key.to_s}=", file[primary_object_key][key])
    end
    created_object
  end

  def ordered_values(hash, order)

  end
end
