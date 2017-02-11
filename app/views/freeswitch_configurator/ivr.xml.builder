xml.configuration name: 'ivr.conf', description: 'IVR SimplePBX' do
  xml.menus do
    @freeswitch.ivr_menus.each do |menu|
      attrs = {}
      attrs['name'] = menu.uuid
      attrs['greet-long'] = resource_to_freeswitch_path(menu.greet_long)
      attrs['greet-short'] = resource_to_freeswitch_path(menu.greet_short)
      attrs['invalid-sound'] = resource_to_freeswitch_path(menu.invalid_sound)
      attrs['exit-sound'] = resource_to_freeswitch_path(menu.exit_sound)
      xml.menu(attrs) do
        menu.ivr_actions.each do |action|
          next unless action.outbound_route.present?
          route = action.outbound_route.routable
          case route
          when Ivr::Menu
            xml.entry action: 'menu-sub', digits: action.digits, param: route.uuid
          else
            xml.entry action: 'menu-exec-app', digits: action.digits, param: outbound_route_bridge_inline(route)
          end
        end
      end
    end
  end
end
