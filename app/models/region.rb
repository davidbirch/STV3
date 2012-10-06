class Region < ActiveRecord::Base
  
  has_many :programs
  
  extend FriendlyId
  friendly_id :region_name, use: :slugged
  
end
