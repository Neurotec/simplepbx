xml.gateway name: outbound.uuid do
  xml.param name: "realm", value: outbound.realm
  xml.param name: "username", value: outbound.username
  xml.param name: "password", value: outbound.password
  xml.param name: "register", value: outbound.register
  xml.param name: "proxy", value: outbound.proxy unless outbound.proxy.to_s.empty?
  xml.param name: "caller-id-in-from", value: outbound.cidfrom
end
