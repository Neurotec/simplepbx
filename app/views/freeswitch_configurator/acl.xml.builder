xml.configuration name: 'acl.conf', description: 'ACL SimplePBX' do
  xml.tag!('network-lists') do
    @freeswitch.endpoints.each do |endpoint|
      xml.list name: endpoint.uuid, default: "deny" do
        xml.node type: "allow", domain: endpoint.domain
        xml.node type: "allow", cidr: "#{endpoint.address}/32"
        endpoint.inbounds.each do |inbound|
          xml.node type: "allow", cidr: "#{inbound.host}/32" if inbound.address_ip?
          xml.node type: "allow", domain: inbound.host if inbound.address_domain?
        end
      end
    end
  end
end
