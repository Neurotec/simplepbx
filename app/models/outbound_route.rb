class OutboundRoute < ApplicationRecord
  belongs_to :freeswitch

  def to_s
    klass = foreign_class_name.constantize.find(foreign_id)
    klass.routable_name
  end

  def routable
    foreign_class_name.constantize.find(foreign_id)
  end
end
