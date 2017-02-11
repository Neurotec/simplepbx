class Outbound < ApplicationRecord
  include Routable
  routable_freeswitch_ref [:endpoint, :freeswitch, :id]
  
  belongs_to :endpoint
  validates :name, presence: true, uniqueness: true, name: true
  validates :realm, presence: true, host: true
  validates :username, allow_blank: true, name: true
  validates :password, allow_blank: true, name: true
  validates :codecs, allow_blank: true, codec: true
  validates :proxy, allow_blank: true, host: true
  validates :cid_name, allow_blank: true, name: true
  validates :cid_number,allow_blank: true,  destination: true
  validate :requirements_on_register
  
  scope :from_user, ->(user) {where(endpoint_id: Endpoint.from_user(user).pluck(:id))}
  def to_s
    name
  end

  def routable_name
    "Outbound(#{endpoint.to_s}/#{name})"
  end
  
  def rpc_register!
    begin
      endpoint.freeswitch.open_xml_rpc!("sofia", ["profile", endpoint.uuid, "register", uuid]).read.include?("+OK")
    rescue Exception => e
      false
    end
  end

  def rpc_unregister!
    begin
      endpoint.freeswitch.open_xml_rpc!("sofia", ["profile", endpoint.uuid, "unregister", uuid]).read.include?("+OK")
    rescue Exception => e
      false
    end
  end

  def rpc_kill!
    begin
      endpoint.freeswitch.open_xml_rpc!("sofia", ["profile", endpoint.uuid, "killgw", uuid]).read.include?("+OK")
    rescue Exception => e
      false
    end
  end

  def rpc_status
    begin
      endpoint.freeswitch.open_xml_rpc_hash!("sofia", ["status", "gateway", uuid])
    rescue Exception => e
      {}
    end
  end

  def online?
    status = rpc_status
    status["STATUS"] == "UP"
  end

  before_create do
    self.uuid = SecureRandom.uuid
  end

  private
  def requirements_on_register
    if register
      errors.add(:username, "need for register") if username.empty?
      errors.add(:password, "need for register") if password.empty?
    end
  end
end
