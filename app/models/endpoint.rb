class Endpoint < ApplicationRecord
  belongs_to :freeswitch
  
  has_many :outbounds
  has_many :inbounds
  has_many :extensions
  has_many :groups
  has_many :routes,  -> { order "position ASC"}, class_name: 'EndpointRoute'
  has_many :destination_profiles
  
  validates :domain, presence: true, uniqueness: true, host: true
  validates :port, presence: true, uniqueness: true, numericality: {only_integer: true} #TODO por dominio
  validates :address, presence: true, host: true
  validates :external_address, host: true
  
  scope :from_user, ->(user) {where(freeswitch_id: user.freeswitches.pluck(:id))}
  def to_s
    "#{domain}##{freeswitch}"
  end

  def rpc_rescan!
    begin
      data = freeswitch.open_xml_rpc!("sofia", ["profile", uuid, "rescan"]).read
      data.include?("Success")
    rescue Exception => e
      false
    end
  end
  
  def rpc_start!
    begin
      data = freeswitch.open_xml_rpc!("sofia", ["profile", uuid, "start"]).read
      data.include?("Success")
    rescue Exception => e
      false
    end
  end
  
  def rpc_stop!
    begin
    data = freeswitch.open_xml_rpc!("sofia", ["profile", uuid, "stop"]).read
    data.include?("Success")
    rescue Exception => e
      false
    end
  end
  
  def rpc_restart!
    begin
    data = freeswitch.open_xml_rpc!("sofia", ["profile", uuid, "restart"]).read
    data.include?("Success")
    rescue Exception => e
      false
    end
  end

  
  def status_online
    begin
      data = freeswitch.open_xml_rpc!("sofia", ["status", "profile", uuid]).read
      status = {}
      data.gsub(/=+$/,'').split("\n").map{|line| line.split("\t").map(&:strip)}.compact.each do |item|
        key, val = item
        next if key.nil? and val.nil?
        status[key.upcase] = val
      end
      status
    rescue Exception => e
      {"OFFLINE" => "OFFLINE"}
    end
  end

  def online?
    begin
      data = freeswitch.open_xml_rpc!("sofia", ["status", "profile", uuid]).read
      !data.include?('Invalid')
    rescue Exception => e
      false
    end
  end
  
  before_create do
    self.uuid = SecureRandom.uuid.to_s
  end
end
