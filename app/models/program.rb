class Program < ActiveRecord::Base
  
  belongs_to :channel
  belongs_to :sport
  belongs_to :region
  
end
