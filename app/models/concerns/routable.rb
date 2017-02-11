module Routable
  extend ActiveSupport::Concern
  
  included do
    def self.routable_freeswitch_ref(chain)
      @@_routable_freeswitch_chain = chain
    end
    
    after_create do
      freeswitch_id = @@_routable_freeswitch_chain.inject(self){|acc, i| acc.send(i)}
      OutboundRoute.find_or_create_by(freeswitch_id: freeswitch_id, foreign_class_name: self.model_name.to_s, foreign_id: self.id)
    end
    
    after_destroy do
      freeswitch_id = @@_routable_freeswitch_chain.inject(self){|acc, i| acc.send(i)}
      OutboundRoute.find_by(freeswitch_id: freeswitch_id, foreign_class_name: self.model_name.to_s, foreign_id: self.id).destroy()
    end
  end

  module ClassMethods
  end
  
  def routable?; true  end
  def routable_name
    self.model_name.to_s
  end
end
