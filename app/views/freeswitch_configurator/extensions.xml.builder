xml.domain name: @endpoint.domain, cacheable: true do
  xml.groups do
    xml.group name: "default" do
      xml.users  do
        @endpoint.extensions.each do |ext|
          xml.user id: ext.username, cacheable: true do
            xml.params do
              xml.param name: 'a1-hash', value: ext.a1_hash
              xml.param name: 'dial-string', value: '{sip_invite_domain=${dialed_domain},presence_id=${dialed_user}@${dialed_domain}}${sofia_contact(${dialed_user}@${dialed_domain})}'
            end
            xml.variables do
              xml.variable name: 'outbound_caller_id_name', value: ext.cid_name
              xml.variable name: 'outbound_caller_id_number', value: ext.cid_number
              xml.variable name: 'sip-allow-multiple-registrations', value: false
            end
          end#xml.user

        end
      end #xml.users
    end #xml.group[default]
    
    @endpoint.groups.each do |group|
      xml.group name: group.uuid do
        if group.extensions.present?
          group.extensions.each do |ext|
            xml.user id: ext.username, type: 'pointer'
          end
        end
      end
    end #xml.group

    xml.group name: "inbound" do
      @endpoint.inbounds.each do |inbound|
        xml.users do
          xml.user id: inbound.username, cacheable: true do
            xml.params do
              xml.param name: 'a1-hash', value: inbound.a1_hash
              xml.param name: 'dial-string', value: '{sip_invite_domain=${dialed_domain},presence_id=${dialed_user}@${dialed_domain}}${sofia_contact(${dialed_user}@${dialed_domain})}'
            end
            xml.variables do
              xml.variable name: 'outbound_caller_id_name', value: inbound.cid_name
              xml.variable name: 'outbound_caller_id_number', value: inbound.cid_number
              xml.variable name: 'sip-allow-multiple-registrations', value: false
            end
          end

        end #xml.users
      end #endpoint.inbounds
    end #xml.group
  end #xml.groups
end

