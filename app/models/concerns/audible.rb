module Audible
  extend ActiveSupport::Concern

  included do
    def self.audible_freeswitch_ref(chain)
      @@_audible_freeswitch_chain = chain
    end

    after_create do
      freeswitch_id = @@_audible_freeswitch_chain.inject(self){|acc, i| acc.send(i)}
      Resource::Object.find_or_create_by(freeswitch_id: freeswitch_id, foreign_class_name: self.model_name.to_s, foreign_id: self.id)
    end
    
    after_destroy do
      freeswitch_id = @@_audible_freeswitch_chain.inject(self){|acc, i| acc.send(i)}
      Resource::Object.find_by(freeswitch_id: freeswitch_id, foreign_class_name: self.model_name.to_s, foreign_id: self.id).destroy
    end
  end

  def audible?; true end
  def audible_name
    self.model_name.to_s
  end
end
