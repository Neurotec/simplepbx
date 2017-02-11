class Resource::Object < ApplicationRecord
  scope :from_user, ->(user) {where(freeswitch_id: user.freeswitches.pluck(:id))}
  
  def to_s
    foreign_class_name.constantize.find(foreign_id).audible_name
  end

  def audible
    foreign_class_name.constantize.find(foreign_id)
  end
end
