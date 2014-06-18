class User < ActiveRecord::Base
  attr_accessible :username,:passwd,:nickname,:portrait_link
end
