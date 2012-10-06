class Channel < ActiveRecord::Base
   
  has_many :programs
  
  extend FriendlyId
  friendly_id :channel_name, use: :slugged
  
end
