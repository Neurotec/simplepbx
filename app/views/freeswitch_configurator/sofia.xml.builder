xml.configuration name: "sofia.conf", description: "Sofia SimplePBX" do
  xml.profiles do
    @freeswitch.endpoints.each do |endpoint|
      xml.profile name: "#{endpoint.uuid}" do
        xml.aliases {}
        xml.domains do
          xml.domain name: endpoint.domain, alias: false, parse: true
          #xml.domain name: "all", alias: "true", parse: "false"
        end
        xml.settings do
          xml.param name: "debug", value: "no"
          xml.param name: "sip-trace", value: "no"
          xml.param name: "sip-capture", value: "no"

          xml.param name: "force-register-domain", value: endpoint.domain
          xml.param name: "force-register-db-domain", value: endpoint.domain
          xml.param name: "presence-hosts", value: endpoint.domain
          xml.param name: "liberal-dtmf", value: "yes"
          xml.param name: "watchdog-enabled", value: "no"
          
          xml.param name: "log-auth-failures", value: "no"
          xml.param name: "context", value: endpoint.uuid
          xml.param name: "dialplan", value: "XML"
          xml.param name: "inbound-codec-prefs", value: "OPUS,PCMA,PCMU,G729"
          xml.param name: "outbound-codec-prefs", value: "OPUS,PCMA,PCMU,G729"
          xml.param name: "rtp-timer-name", value: "soft"
          xml.param name: "sip-port", value: endpoint.port
          xml.param name: "sip-ip", value: endpoint.address
          xml.param name: "rtp-ip", value: endpoint.address
          #TODO  hold music?
          xml.param name: "hold-music", value: "$${hold_music}"

          xml.param name: "record-path", value: "$${recording_dir}"
          xml.param name: "record-template", value: "${caller_id_number}.${target_domain}.${strftime(%Y-%m-%d-%H-%M-%S)}.wav"
          xml.param name: "manage-presence", value: "true"
          xml.param name: "inbound-codec-negotiation", value: "generous"
          xml.param name: "inbound-late-negotiation", value: "true"
          xml.param name: "auth-calls", value: "true"
          xml.param name: "nonce-ttl", value: 60
          xml.param name: "inbound-reg-force-matching-username", value: true
          xml.param name: "auth-all-packets", value: false
          xml.param name: "challenge-realm", value: "auto_from"
          xml.param name: "rfc2833-pt", value: 101
          if !endpoint.external_address.to_s.empty?
            xml.param name: "ext-sip-ip", value: endpoint.external_address
            xml.param name: "ext-rtp-ip", value: endpoint.external_address
          else
            xml.param name: "ext-sip-ip", value: "auto-nat"
            xml.param name: "ext-rtp-ip", value: "auto-nat"
          end

          xml.param name: "apply-nat-acl", value:"nat.auto"
          xml.param name: "apply-inbound-acl", value: endpoint.uuid
          xml.param name: "local-network-acl", value: "localnet.auto"
          #xml.param name: "aggressive-nat-detection", value: true
          xml.param name: "rtp-timeout-sec", value: 300
          xml.param name: "rtp-hold-timeout-sec", value: 1800
        end
        
        xml.gateways do
          if endpoint.outbounds.present?
            xml << render(endpoint.outbounds, formats: :xml)
          end
        end
      end
    end
  end
end
