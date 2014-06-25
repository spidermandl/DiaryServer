class Diary < ActiveRecord::Base
   attr_accessible :user_id,:content,:user_created_at,:user_updated_at
   belongs_to :user
end
