# frozen_string_literal: true

require "pure_validator"
require "byebug"

# This class validate ObjectSaver attributes
class ObjectSaverValidator
  include PureValidator::Validator

  validates :file_path, presence: true

  validate :file_path_should_exist

  def file_path_should_exist(object, errors)
    file_path = object.file_path

    errors.add(:file_path, "File does not exist, please create and try again") if !file_path.nil? && !File.file?(file_path)
  end
end
