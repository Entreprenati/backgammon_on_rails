class User < ActiveRecord::Base

  has_many :black_games, :class_name => 'Game', :foreign_key => 'black_player_id', dependent: :destroy
  
  has_many :white_games, :class_name => 'Game', :foreign_key => 'white_player_id', dependent: :destroy

  has_many :foe_requesters, :class_name => 'Foe', :foreign_key => 'foe_requester_id', dependent: :destroy
  
  has_many :foe_responders, :class_name => 'Foe', :foreign_key => 'foe_responders_id', dependent: :destroy

  has_attached_file :avatar, 
    :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
    :url => "/system/:attachment/:id/:style/:filename", 
    :styles => { :medium => "200x200#", :thumb => "100x100#" },
    :default_url => "/images/:style/miniMe.jpg"

    do_not_validate_attachment_file_type :avatar
    # validates_attachment_file_name :avatar, :matches => [/png\Z/, /jpe?g\Z/]

    validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

end
