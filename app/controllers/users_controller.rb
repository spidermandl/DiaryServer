#encoding = utf-8
class UsersController < ApplicationController
   @@user_session={}
   def login 
     username=params[:username]
     passwd=Digest::MD5.hexdigest(params[:passwd])
     str = {"fail" => "username or password wrong"}
     user= User.where("username"=> username,"passwd"=>passwd).first
     if (user!=nil)
        uuid=SecureRandom.hex
        Rails.cache.write(uuid,user.id)
        str={"session_id"=>uuid,"success"=>200}
     end
     render :json => str
   end

   def register
      use = params[:username]
      pwd=Digest::MD5.hexdigest(params[:passwd])
      eml= params[:email]
      response={"fail" => "user exists"}
      user=User.find_by(username: use,passwd: pwd)
      if (user == nil)	
	  user = User.create(username: use,passwd: pwd,email: eml)
          if (user==nil)
             response = {"fail" => "user fail to create"}
          else
             response = {"success" => "ok"}
          end
      end
      render :json => response
   end
end
