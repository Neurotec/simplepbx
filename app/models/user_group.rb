class UserGroup < ApplicationRecord
  has_and_belongs_to_many :group_permissions
end
