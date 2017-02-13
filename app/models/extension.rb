class Extension < ApplicationRecord
  include Routable
  routable_freeswitch_ref [:endpoint, :freeswitch, :id]
  
  belongs_to :endpoint
  belongs_to :extension_profile

  validates :username, presence: true, name: true
  validates :password, name: true, presence: true
  validates :vmpassword, allow_blank: true, numericality: { only_integer: true }
  validates :cid_name, allow_blank: true, name: true
  validates :cid_number, allow_blank: true,  numericality: { only_integer: true }
  
  scope :from_user, ->(user) {where(endpoint_id: Endpoint.from_user(user).pluck(:id))}

  def contact
    "#{username}@#{endpoint.domain}"
  end
  
  def to_s
    contact
  end

  def routable_name
    "Extension(#{username}@#{endpoint.domain})"
  end
  
  def a1_hash
    Digest::MD5.hexdigest('%s:%s:%s' % [username, endpoint.address, password])
  end

  def expire_freeswitch_cache_user
    self.endpoint.freeswitch.open_xml_rpc!("xml_flush_cache", ["id", self.username, self.endpoint.domain])
  end
end
