class User < ActiveRecord::Base
  attr_accessible :id,:username,:passwd,:nickname,:portrait_link
end
