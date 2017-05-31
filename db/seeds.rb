# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


exphone = ExtensionProfile.create!(name: 'PHONE')
[
  ['export', 'dialed_extension=$1'],
  ['bind_meta_app', '1 b s execute_extension::dx XML features'],
  ['bind_meta_app', '2 b s record_session::$${recordings_dir}/${caller_id_number}.${strftime(%Y-%m-%d-%H-%M-%S)}.wav'],
  ['bind_meta_app', '3 b s execute_extension::cf XML features'],
  ['bind_meta_app',  '4 b s execute_extension::att_xfer XML features'],
  ['set', '${us-ring}'], #TODO desde tabla
  ['set',  'transfer_ringback=$${hold_music}' ], #TODO desde tabla
  ['set', 'hangup_after_bridge=true'],
  ['hash',  'insert/${domain_name}-call_return/${dialed_extension}/${caller_id_number}'],
  ['hash',  'insert/${domain_name}-last_dial_ext/${dialed_extension}/${uuid}'],
  ['hash',  'insert/${domain_name}-last_dial_ext/global/${uuid}']
].each do |action|
  app, data = action
  ExtensionProfileAction.create!(extension_profile: exphone, application: app, data: data)
end


Callcenter::QueueProfile.create!(name: 'GENERIC')


#Permissions
group_admin = UserGroup.create!(name: "Admin")
group_vendor_lock = UserGroup.create!(name: "Vendor Lock")

{
  group_admin => [
             [:extensions, [:create, :read, :update, :delete],
              "Extension Management"],
             [:groups, [:create, :read, :update, :delete],
              "Extension Group management"],
             [:extension_groups, [:create, :read, :update, :delete],
              "Extensions in Groups Management"],
             [:callcenter_queues, [:create, :read, :update, :delete],
              "Callcenter Queues Management"],
             [:callcenter_tiers, [:create, :read, :update, :delete],
              "Callcenter Tiers Management"],
             [:endpoint_routes, [:create, :read, :update, :delete],
              "Endpoint Routes Management"],
             [:cdr, [:create, :read, :update, :delete],
              "CDR Management"],
             [:cdr_recording, [:read],
              "CDR Recording player"],
             [:ivr_menus, [:create, :read, :update, :delete],
              "IVR Menus Management"],
             [:resources_records, [:create, :read, :update, :delete],
              "Resources Records Management"],
             [:endpoints, [:create, :read, :update, :delete],
              "Endpoint Management"],
             [:inbounds, [:create, :read, :update, :delete],
              "Inbounds Management"],
             [:outbounds, [:create, :read, :update, :delete],
              "Outbounds Management"],
             [:freeswitches, [:create, :read, :update, :delete],
              "Freeswitch(s) Management"],
             [:user_groups, [:create, :read, :update, :delete],
              "User Groups(s) Management"],
             [:users, [:create, :read, :update, :delete],
              "User(s) Management"]
  ],
  group_vendor_lock => [
    [:extensions, [:create, :read, :update, :delete],
     "Extension Management"],
    [:groups, [:create, :read, :update, :delete],
     "Extension Group management"],
    [:extension_groups, [:create, :read, :update, :delete],
     "Extensions in Groups Management"],
    [:callcenter_queues, [:create, :read, :update, :delete],
     "Callcenter Queues Management"],
    [:callcenter_tiers, [:create, :read, :update, :delete],
     "Callcenter Tiers Management"],
    [:endpoint_routes, [:create, :read, :update, :delete],
     "Endpoint Routes Management"],
    [:cdr, [:create, :read, :update, :delete],
     "CDR Management"],
    [:cdr_recording, [:read],
     "CDR Recording player"],
    [:ivr_menus, [:create, :read, :update, :delete],
     "IVR Menus Management"],
    [:resources_records, [:create, :read, :update, :delete],
     "Resources Records Management"]
  ]
}.each do |group, permissions|
  permissions.each do |permission|
    name_permission, alloweds, description = permission
  
    allow_create =  alloweds.member?(:create)
    allow_read = alloweds.member?(:read)
    allow_update = alloweds.member?(:update)
    allow_delete = alloweds.member?(:delete)

    gp = GroupPermission.find_or_create_by(name: name_permission,
                                           description: description,
                                           allow_create: allow_create,
                                           allow_read: allow_read,
                                           allow_update: allow_update,
                                           allow_delete: allow_delete)
    group.group_permissions << gp
  end
  group.save
end

User.create!(email: 'admin@simplepbx.com', password: 'simplepbx', password_confirmation: 'simplepbx', user_group: group_admin)
User.create!(email: 'vendor@simplepbx.com', password: 'simplepbx', password_confirmation: 'simplepbx', user_group: group_vendor_lock)
