require 'test_helper'

class FreeswitchConfiguratorControllerTest < ActionDispatch::IntegrationTest
  test "should get not configuration" do
    get freeswitch_configurator_configuration_url
    xml = Hash.from_xml(response.body)
    #assert xml["document"]["section"]["result"]["status"] == "not found"

    assert_response :success
  end

  test "should get configuration for sofia.conf" do
    fs = Freeswitch.create!(host: '127.0.0.1')
    ep = Endpoint.create!(freeswitch: fs, domain: "localhost", address: '127.0.0.1', port: 5060)
    Outbound.create!(endpoint: ep, name: 'teste', realm: 'medellin', register: false)
    Inbound.create!(endpoint: ep, name: 'testa', username: 'test', host: '127.0.0.2')
    get freeswitch_configurator_configuration_url(section: 'configuration', key_value: "sofia.conf")
    xml = Hash.from_xml(response.body)
    conf = xml["document"]["section"]["configuration"]
    assert conf["profiles"].count == 1
    assert conf["profiles"]["profile"]["gateways"].count ==  1
    assert_response :success
  end

  test "should get directory extensions" do
    fs = Freeswitch.create!(host: '127.0.0.1')
    ep = Endpoint.create!(freeswitch: fs, domain: "localhost", address: '127.0.0.1', port: 5060)
    Outbound.create!(endpoint: ep, name: 'teste', realm: 'medellin', register: false)
    Inbound.create!(endpoint: ep, name: 'testa', username: 'hola', host: '127.0.0.2')
    get freeswitch_configurator_directory_url( sip_auth_method: 'REGISTER', section: 'directory', tag_name: 'domain')
    assert_response :success
  end

  test "should get diaplan" do
    fs = Freeswitch.create!(host: '127.0.0.1')
    extp = ExtensionProfile.create!(name: 'PHONE')
    ep = Endpoint.create!(freeswitch: fs, domain: "localhost", address: '127.0.0.1', port: 5060)
    Outbound.create!(endpoint: ep, name: 'teste', realm: 'medellin', register: false)
    Inbound.create!(endpoint: ep, name: 'testa', username: 'hola', host: '127.0.0.2')
    Extension.create!(endpoint: ep, username: '1001', extension_profile: extp)
    dp = DestinationProfile.create!(endpoint: ep, condition_field: 'destination_number', condition_expression: '99999')
    DestinationProfileAction.create!(destination_profile: dp, application: 'hangup')

    get freeswitch_configurator_dialplan_url
    assert_response :success
  end

  test "should get dialplan" do
    get freeswitch_configurator_dialplan_url
    assert_response :success
  end

  test "should get directory" do
    get freeswitch_configurator_directory_url
    assert_response :success
  end

end
