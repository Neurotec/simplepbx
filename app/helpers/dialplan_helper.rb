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
    if route.respond_to?(:routable_outbound_inline)
      route.routable_outbound_inline
    end
  end
    
  #Solo construye el perfil para el dialplan
  #no hace ningun tipo de enrutamiento condition/bridge
  def dialplan_profile_xml(builder, endpoint, obj)
    builder.action application: 'set', data: "domain_name=#{endpoint.domain}"
    
    case obj
    when OutboundRoute
      dialplan_profile_xml(builder, endpoint, obj.routable)
    when Array
      obj.each{|i| dialplan_profile_xml(builder, endpoint, i)}
    else
      if obj.routable?
        obj.routable_profile_xml(builder, endpoint)
      else
        raise ArgumentError, "obj for dialplan unknow #{obj.class.to_s}"
      end
    end
  end

  def dialplan_outbound_xml(builder, endpoint, obj)
    case obj
    when OutboundRoute
      dialplan_outbound_xml(builder, endpoint, obj.routable)
    when Array
      obj.each{|i| dialplan_outbound_xml(builder, endpoint, i)}
      #@TODO implementar voicemal
    else
      if obj.routable?
        obj.routable_outbound_xml(builder, endpoint)
      else
        raise ArgumentError, "obj for dialplan unknow #{obj.class.to_s}"
      end
    end
  end

end
