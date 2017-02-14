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

  def routable_profile_xml(builder, endpoint)
    if do_record?
      builder.action application: "set", data: "recording_follow_transfer=true"
      builder.action application: "set", data: "RECORD_TITLE=#{username}"
      builder.action application: "set", data: "RECORD_SOFTWARE=SimplePBX"
      builder.action application: "set", data: "RECORD_DATE=${strftime(%Y-%m-%d %H:%M)}"
      builder.action application: "set", data: "RECORD_STEREO=true"
      builder.action application: "set", data: "recording_path=$${recordings_dir}/${caller_id_number}.#{endpoint.domain}.${strftime(%Y-%m-%d-%H-%M-%S)}.wav"
      builder.action application: "set", data: "execute_on_answer=record_session ${recording_path}"
    end
    builder.action application: 'set', data: "effective_caller_id_number=#{cid_number}" if cid_number.present?
    builder.action application: 'set', data: "effective_caller_id_name=#{cid_name}" if cid_number.present?
    extension_profile.actions.each do |action|
      builder.action application: action.application, data: action.data
    end
  end

  def routable_outbound_xml(builder, endpoint)
    builder.action application: 'bridge', data: "user/#{username}@#{endpoint.domain}"
  end

  def routable_outbound_inline
    "transfer #{username} XML #{endpoint.uuid}"
  end

  def a1_hash
    Digest::MD5.hexdigest('%s:%s:%s' % [username, endpoint.address, password])
  end

  def expire_freeswitch_cache_user
    self.endpoint.freeswitch.open_xml_rpc!("xml_flush_cache", ["id", self.username, self.endpoint.domain])
  end
end
