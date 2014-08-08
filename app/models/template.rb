class Template < ActiveRecord::Base
  attr_accessible :user_id,:format,:user_created_at,:user_updated_at,:name,:selected
  belongs_to :user
end
