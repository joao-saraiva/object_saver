require 'pure_validator'

class ObjectSaverValidator
  include PureValidator::Validator
  
  validates :directory, presence: true
end