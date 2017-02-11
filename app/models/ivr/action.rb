class Ivr::Action < ApplicationRecord
  belongs_to :menu, class_name: 'Ivr::Menu', optional: true
  belongs_to :outbound_route, optional: true

  validates :digits, allow_blank: true, numericality: {only_integer: true}
  def to_s
    outbound_route.to_s
  end
end
