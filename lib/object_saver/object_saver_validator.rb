require 'pure_validator'

require 'byebug'

class ObjectSaverValidator
  include PureValidator::Validator
  
  validates :directory, presence: true

  validate :directory_should_exist

  def directory_should_exist(object, errors)
    directory = object.directory

    errors.add(:directory, 'directory does not exist in your system') if !directory.nil? && !Dir.exist?(directory)
  end
end