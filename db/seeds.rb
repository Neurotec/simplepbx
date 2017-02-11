# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(email: 'admin@simplepbx.com', password: 'simplepbx', password_confirmation: 'simplepbx')
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
