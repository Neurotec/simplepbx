class Ivr::Menu < ApplicationRecord
  include Routable
  routable_freeswitch_ref [:freeswitch, :id]
  
  belongs_to :freeswitch
  belongs_to :greet_long, class_name: 'Resource::Object', foreign_key: :greet_long_id
  belongs_to :greet_short, class_name: 'Resource::Object', foreign_key: :greet_short_id
  belongs_to :invalid_sound, class_name: 'Resource::Object', foreign_key: :invalid_sound_id
  belongs_to :exit_sound, class_name: 'Resource::Object', foreign_key: :exit_sound_id

  has_many :ivr_actions, class_name: 'Ivr::Action', dependent: :destroy

  validates :name, name: true, presence: true
  accepts_nested_attributes_for :ivr_actions

  before_create do
    self.uuid = SecureRandom.uuid
  end

  scope :from_user, ->(user){where(freeswitch_id: user.freeswitches.pluck(:id))}
  
  def routable_name
    "Ivr::Menu(#{name}##{freeswitch})"
  end
  
  def actions
    ivr_actions.reject{|i| !i.outbound_route.present?}
  end


end
