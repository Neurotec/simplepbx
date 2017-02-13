require 'open-uri'

class Freeswitch < ApplicationRecord
  has_many :endpoints
  has_many :cdrs
  has_many :callcenter_queues, class_name: 'Callcenter::Queue'
  has_many :ivr_menus, class_name: 'Ivr::Menu'
  
  validates :name, presence: true, name: true
  validates :record_public_user, name: true
  validates :event_socket_port, numericality: { only_integer: true }
  validates :xml_rpc_port, numericality: { only_integer: true }
  scope :from_user, ->(user){where(user_id: user.id)}

  after_create do
    keys_path = Rails.root.join('keys', id.to_s).to_s.shellescape
    private_key_path = Rails.root.join('keys', id.to_s)
    public_key_path = Rails.root.join('keys', "#{id.to_s}.pub").to_s.shellescape
    pem_path = Rails.root.join('keys', "#{id.to_s}.pem").to_s.shellescape
    
    %x<ssh-keygen -q -N "" -f #{keys_path}>
    system("cat #{private_key_path} #{public_key_path} > #{pem_path}")
  end

  def record_pem_path
    Rails.root.join('keys', "#{id}.pem")
  end
  
  def record_public_key
    public_key_path = Rails.root.join('keys', "#{id}.pem")
    return File.read(public_key_path) if File.exists?(public_key_path)
    ""
  end

  def to_s
    name
  end

  def open_xml_rpc!(cmd, args = [], options = {})
    txtargs = args.join(" ")
    url = "http://#{host}:#{xml_rpc_port}/xmlapi/#{cmd}?#{txtargs}"
    puts url
    open(url, {read_timeout: 3,
         http_basic_authentication: [xml_rpc_user, xml_rpc_pass]}.merge(options))
  end

  def open_xml_rpc_hash!(cmd, args = [], options = {})
    status= {}
    data = open_xml_rpc!(cmd, args, options).read
    data.gsub(/=+$/,'').split("\n").map{|line| line.split("\t").map(&:strip)}.compact.each do |item|
        key, val = item
        next if key.nil? and val.nil?
        status[key.upcase] = val
      end
    status
  end
  
  def online?
    #@secure
    begin
      open_xml_rpc!("status")
      true
    rescue Exception => e
      false
    end           
  end
end
