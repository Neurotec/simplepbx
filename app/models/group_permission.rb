class GroupPermission < ApplicationRecord
  has_and_belongs_to_many :user_groups
end
