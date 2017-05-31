class UserGroup < ApplicationRecord
  has_many :group_permissions
end
