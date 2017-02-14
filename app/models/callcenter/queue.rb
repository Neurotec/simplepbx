class Callcenter::Queue < ApplicationRecord
  include Routable
  routable_freeswitch_ref [:freeswitch, :id]
  
  belongs_to :callcenter_queue_profile, class_name: 'Callcenter::QueueProfile'
  belongs_to :freeswitch
  has_many :tiers, class_name: 'Callcenter::Tier', foreign_key: 'callcenter_queue_id'
  
  validates :name, name: true, presence: true

  STRATEGY = [
    'ring-all',
    'longest-idle-agent',
    'round-bin',
    'top-down',
    'agent-with-least-talk-time',
    'agent-with-fewest-calls',
    'sequentially-by-agent-order',
    'random',
    'ring-progressively'
  ]
  
  def profile; callcenter_queue_profile end
  
  scope :from_user, ->(user){where(freeswitch_id: user.freeswitches.pluck(:id))}
  def to_s; "#{freeswitch.name}/#{name}" end
  
  def routable_name
    "Queue(#{name}##{freeswitch})"
  end

  def routable_profile_xml(builder, endpoint)
    builder.action application: 'set', data: 'hangup_after_bridge=true'
    builder.action application: 'pre_answer'
  end

  def routable_outbound_xml(builder, endpoint)
    builder.action application: 'callcenter', data: "#{uuid}"
  end

  def routable_outbound_inline
    "callcenter #{uuid}"
  end

  before_create do
    self.uuid = SecureRandom.uuid
  end
end
