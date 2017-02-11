@freeswitch.endpoints.each do |endpoint|
  xml.context name: endpoint.uuid do
    xml.extension name: 'dx' do
      xml.condition field: 'destination_number', expression: '^dx$' do
        xml.action application: 'answer'
        xml.action application: 'read', data: "11 11 'tone_stream://%(10000,0,350,440)' digits 5000 #"
        xml.action application: 'execute_extension', data: 'is_transfer XML features'
      end
    end #xml.extension[dx]
    xml.extension name: 'att_xfer' do
      xml.condition field: 'destination_number', expression: '^att_xfer$' do
        xml.action application: 'read', data: "3 4 'tone_stream://%(10000,0,350,440)' digits 30000 #"
        xml.action application: 'set', data: 'origination_cancel_key=#'
        xml.action application: 'att_xfer', data: 'user/${digits}@${domain}'
      end
    end #xml.extension[att_xfer]

    xml.extension name: 'is_transfer' do
      xml.condition field: 'destination_number', expression: '^is_transfer$'
      xml.condition field: '${digits}', expression: '^(\d)$' do
        xml.action application: 'transfer', data: "-bleg ${digits} XML #{endpoint.uuid}"
        xml.tag!('anti-action', application: 'eval', data: 'cancel transfer')
      end
    end #xml.extension[is_transfer]

    xml.extension name: 'resource_record' do
      xml.condition field: 'destination_number', expression: '^\*732$' do
        xml.action application: 'answer'
        xml.action application: 'set', data: 'playback_terminators=#'
        xml.action application: 'set', data: 'RECORD_SOFTWARE=SimplePBX'
        xml.action application: 'set', data: 'recording_path=$${recordings_dir}/resource_${uuid}.wav'
        xml.action application: 'set', data: "api_hangup_hook=curl_sendfile #{resource_record_upload_url(@freeswitch)} audio=${recording_path} nopost none uuid"
        xml.action application: 'record', data: '${recording_path}'
        xml.action application: 'hangup', data: 'NORMAL_CLEARING'
      end
    end
    
    endpoint.destination_profiles.each do |route|
      xml.extension name: route.uuid do
        xml.condition field: route.condition_field, expression: route.condition_expression do
          route.actions.each do |action|
            xml.action application: action.application, data: action.data
          end
        end #xml.condition
      end #xml.extension
    end


    #por cada extension creamos segun su perfil
    endpoint.extensions.each do |ext|
      xml.extension name: "profile_#{ext.username}", continue: "true" do
        xml.condition field: "username", expression: "^(#{ext.username})$", break: 'never' do
          dialplan_profile_xml(xml, endpoint, ext)
        end
      end

      xml.extension name: "call_#{ext.username}" do
        xml.condition field: 'destination_number', expression: "^(#{ext.username})$" do
          dialplan_outbound_xml(xml, endpoint, ext)
        end #xml.condition
      end
    end #endpoint.extensions

    endpoint.routes.each do |route|
      xml.extension name: route.uuid do
        xml.condition field: 'destination_number', expression: route.destination_number do
          xml.action application: 'set', data: 'hangup_after_bridge=true'
          if route.outbound_routes.present?
            dialplan_profile_xml(xml, endpoint, route.outbound_routes.to_a)
            dialplan_outbound_xml(xml, endpoint, route.outbound_routes.to_a)
          end
        end
      end
    end #endpoint.routes
    
  end #xml.context
end
