module DialplanHelper

  def resource_to_freeswitch_path(obj)
    return "" unless obj.kind_of?(Resource::Object)
    resource = obj.audible
    case resource
    when Resource::Record
      "http_cache://#{play_resource_record_url(resource).gsub("http://", "")}"
    end
  end

  def outbound_route_bridge_inline(route)
    case route
    when Extension
      "transfer #{route.username} XML #{route.endpoint.uuid}"
    when Callcenter::Queue
      "callcenter #{route.uuid}"
    when Group
      "bridge group_call(#{route.uuid}@#{route.endpoint.domain})"
    end
  end
    
  #Solo construye el perfil para el dialplan
  #no hace ningun tipo de enrutamiento condition/bridge
  def dialplan_profile_xml(builder, endpoint, obj)
    builder.action application: 'set', data: "domain_name=#{endpoint.domain}"
    
    case obj
    when Outbound
      builder.action application: 'set', data: "effective_caller_id_number=#{obj.cid_number}" if obj.cid_number.present?
      builder.action application: 'set', data: "effective_caller_id_name=#{obj.cid_name}" if obj.cid_name.present?
    when Inbound
    when Extension
      if obj.do_record?
        builder.action application: "set", data: "recording_follow_transfer=true"
        builder.action application: "set", data: "RECORD_TITLE=#{obj.username}"
        builder.action application: "set", data: "RECORD_SOFTWARE=SimplePBX"
        builder.action application: "set", data: "RECORD_DATE=${strftime(%Y-%m-%d %H:%M)}"
        builder.action application: "set", data: "RECORD_STEREO=true"
        builder.action application: "set", data: "recording_path=$${recordings_dir}/${caller_id_number}.#{endpoint.domain}.${strftime(%Y-%m-%d-%H-%M-%S)}.wav"
        builder.action application: "set", data: "execute_on_answer=record_session ${recording_path}"
      end
      builder.action application: 'set', data: "effective_caller_id_number=#{obj.cid_number}" if obj.cid_number.present?
      builder.action application: 'set', data: "effective_caller_id_name=#{obj.cid_name}" if obj.cid_number.present?
      obj.extension_profile.actions.each do |action|
        builder.action application: action.application, data: action.data
      end
    when Group
    when Callcenter::Queue
      #aqui podemos implementar por ejemplo
      #<!-- limit 3 calls to this destination number per 1 second, otherwise give congestion message -->
      #<action application="limit" data="hash inbound ${destination_number} 3/1 !NORMAL_CIRCUIT_CONGESTION"/>
      builder.action application: 'set', data: 'hangup_after_bridge=true'
      builder.action application: 'pre_answer'
    when OutboundRoute
      dialplan_profile_xml(builder, endpoint, obj.routable)
    when Array
      obj.each{|i| dialplan_profile_xml(builder, endpoint, i)}
    when Ivr::Menu
    else
      raise ArgumentError, "obj for dialplan unknow #{obj.class.to_s}"
    end
  end

  def dialplan_outbound_xml(builder, endpoint, obj)
    case obj
    when Outbound
      builder.action application: 'bridge', data: "sofia/gateway/#{obj.uuid}/$1"
    when Inbound
      builder.action application: 'bridge', data: "user/#{obj.username}/$1"
    when Extension
      builder.action application: 'bridge', data: "user/#{obj.username}@#{endpoint.domain}"
    when Group
      builder.action application: 'bridge', data: "group/#{obj.uuid}@#{endpoint.domain}"
    when Callcenter::Queue
      builder.action application: 'callcenter', data: "#{obj.uuid}"
    when Ivr::Menu
      builder.action application: 'ivr', data: "#{obj.uuid}"
    when OutboundRoute
      dialplan_outbound_xml(builder, endpoint, obj.routable)
    when Array
      obj.each{|i| dialplan_outbound_xml(builder, endpoint, i)}
      #@TODO implementar voicemal
    else
      raise ArgumentError, "obj for dialplan unknow #{obj.class.to_s}"
    end
  end

end
