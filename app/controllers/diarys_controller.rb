class DiarysController < ApplicationController
   
   def user_identify
       userid=Rails.cache.read(params[:session_id])
       @user=nil
       @user=User.find_by(id: userid)
       if(user==nil)
          return str={"fail" => "session expired"}
       end
       return nil
   end

   def create
       result = user_identify
       if(@user != nil)
           con = params[:content]
           len=Diary.where("created_at > '"+Time.now.strftime("%Y%m%d")+"' and user_id = "+@user.id.to_s).length
           if (len==0)
              today= Diary.create(user_id: @user.id,content: con) 
              if(today!=nil)
                 result = {"success" => "diary be created"} 
              else
             	 result = {"fail" => "diary failed to be created"}
              end
           else
              result={"fail"=>"can't not be created"}
           end
       end
       render :json => result
   end
   
   def update     
       result = user_identify
       if(@user != nil)
           con = params[:content]
           today=Diary.where("created_at > '"+Time.now.strftime("%Y%m%d")+"' and user_id = "+@user.id.to_s).first
           if (today!=nil)
              today.update(content: con)
              result = {"success" => "diary be updated"} 
           else
              result={"fail"=>"no diary be found"}
           end
       end
       render :json => result
   end

   def diarys
      result=user_identify
      if(@user != nil)
      end
      render :json => result
   end
   private:
       user_identify
end
