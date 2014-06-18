class Template < ActiveRecord::Base
  attr_accessible :user_id,:format
  belongs_to :user
end
