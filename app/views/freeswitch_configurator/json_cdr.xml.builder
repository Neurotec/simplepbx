xml.configuration name: 'json_cdr.conf', description: 'JSON CDR SimplePBX' do
  xml.settings do
    xml.param name: 'log-b-leg', value: true
    xml.param name: 'prefix-a-leg', value: false
    xml.param name: 'encode-values', value: true
    xml.param name: 'log-http-and-disk', value: false
    xml.param name: 'log-dir', value: false
    xml.param name: 'rotate', value: false
    xml.param name: 'url', value: freeswitch_configurator_json_cdr_url
    xml.param name: 'auth-scheme', value: 'basic'
    xml.param name: 'cred', value: ''
    xml.param name: 'encode', value: 'base64|true|false'
    xml.param name: 'delay', value: 5
    xml.param name: 'disable-100-continue', value: false
    xml.param name: 'err-log-dir', value: ''
  end
end
