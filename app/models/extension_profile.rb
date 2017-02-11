class ExtensionProfile < ApplicationRecord
  has_many :extensions
  has_many :actions, class_name: 'ExtensionProfileAction'

  def to_s
    name
  end

end
