class Inbound < ApplicationRecord
  belongs_to :endpoint

  validates :username, presence: true, name: true
  validates :password, name: true
  validates :host, host: true
  validates :name, name: true
  validates :cid_name, name: true
  validates :cid_number, destination: true
  
  scope :from_user, ->(user) {where(endpoint_id: Endpoint.from_user(user).pluck(:id))}
  
  before_create do
    self.uuid = SecureRandom.uuid
  end

  def to_s
    name
  end
  
  def address_ip?
    return true
  end
  def address_domain?
    return false
  end
end
