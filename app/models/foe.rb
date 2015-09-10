class Foe < ActiveRecord::Base

  belongs_to :foe_requester, :class_name => 'User', :foreign_key => 'foe_requester_id'
  
  belongs_to :foe_responder, :class_name => 'User', :foreign_key => 'foe_responder_id'

end
