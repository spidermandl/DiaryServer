class User < ActiveRecord::Base
  attr_accessible :id,:username,:email,:passwd,:nickname,:portrait_link
end
