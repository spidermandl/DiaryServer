#encoding = utf-8
class UsersController < ApplicationController
   @@user_session={} #存放所有用户session
   @@update_url = "http://114.215.120.47:3000/diary.apk" #新android apk下载地址
   @@android_version="1.0.1"#android apk版本号
   
   def login 
     username=params[:username]
     passwd=Digest::MD5.hexdigest(params[:passwd])
     str = {"fail" => "username or password wrong"}
     user= User.where("(username = '"+username+"' or email = '"+username+"') and passwd = '"+passwd+"'").first
     if (user!=nil)
        uuid=SecureRandom.hex
        Rails.cache.write(uuid,user.id)
        str={"session_id"=>uuid,"user_id"=>user.id, 
             "user_name"=> user.username,"user_email"=>user.email,
             "nickname"=> user.nickname,"success"=>200}
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
   
   #版本检查 
   def check_version
       old_version=params[:version]
       response={"version" => @@android_version}
       puts old_version
       puts @@android_version
       if (old_version!=@@android_version)
          response={"url" => @@update_url}
       end
       render :json => response
   end


end
