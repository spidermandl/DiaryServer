#encoding = utf-8
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
           c_time = params[:created_time]
           #len=Diary.where("created_at > '"+Time.now.strftime("%Y%m%d")+"' and user_id = "+@user.id.to_s).length
           len=Diary.where("user_created_at = "+c_time+"and user_id = "+@user.id.to_s).length
           if (len==0)
              today= Diary.create(user_id: @user.id,content: con,user_created_at: DateTime.parse(c_time), user_updated_at: DateTime.parse(c_time)) 
              if(today!=nil)
                 result = {"success" => "diary be created",
                           "diary_id" => today.id} 
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
           c_time = params[:created_time]
           u_time = params[:updated_time]
           #today=Diary.where("created_at > '"+Time.now.strftime("%Y%m%d")+"' and user_id = "+@user.id.to_s).first
           today=Diary.where("user_created_at = "+c_time+"and user_id = "+@user.id.to_s).first
           if (today!=nil)
              today.update(content: con, user_updated_at: DateTime.parse(u_time))
              result = {"success" => "diary be updated"} 
           else
              result={"fail"=>"no diary be found"}
           end
       end
       render :json => result
   end

   def list
      result=user_identify
      if(@user != nil)
         user_diarys=Diary.where("user_id = "+@user.id.to_s)
         result ={"diarys" => user_diarys}
      end
      render :json => result
   end

   private:
       user_identify
end
