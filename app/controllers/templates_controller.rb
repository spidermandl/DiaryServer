class TemplatesController < ApplicationController
   def list #获取用户模板列表
      result=user_identify
      if(@user !=nil)
         c_time = params[:user_created_time]
         if (c_time!=nil)#获取该创建时间以后的列表
            user_templates = Template.where("user_created_at > '"+c_time+"' and user_id = "+@user.id.to_s)
         else
            user_templates = Template.where(user_id: @user.id)
         end
         
         
         models=[] #以json格式返回数据
         user_templates.each{|d|
            models<<{"id" => d.id,
                     "user_id" => d.user_id,
                     "format" => d.format,
                     "user_created_at" => d.user_created_at.strftime("%Y-%m-%d %H:%M:%S"),
                     "user_updated_at" => d.user_updated_at.strftime("%Y-%m-%d %H:%M:%S"),
                     "name" => d.name,
                     "selected" => d.selected
                    }
         }
         puts models
         result ={"templates" => models,
                  "success" => "list fetched successfully"
                 }
      end
      render :json => result
   end

   def operate #操作日记模板 增 删 改
      result = user_identify
      add=JSON.parse(params[:add_temps])
      update=JSON.parse(params[:update_temps])
      del=JSON.parse(params[:del_temps])
      
      #添加数据
      add.each{|d|
          tempName = d["name"]
          tempFormat = d["format"]
          tempSelected = d["selected"]
          c_user_created_at=d["user_created_at"]
          c_user_updated_at=d["user_updated_at"]
          temp=Template.where("user_created_at = '"+c_user_created_at+"' and user_id = "+@user.id.to_s).first
          if (temp==nil)
             Template.create(user_id: @user.id,format: tempFormat,user_created_at: DateTime.parse(c_user_created_at),
                             user_updated_at: DateTime.parse(c_user_updated_at),selected: tempSelected,name: tempName)
          else 
             temp.update(format: tempFormat,user_updated_at: DateTime.parse(c_user_updated_at),selected: tempSelected,name: tempName)
          end
      }
      #更新数据
      update.each{|d|      
          tempName = d["name"]
          tempFormat = d["format"]
          tempSelected = d["selected"]
          c_user_created_at=d["user_created_at"]
          c_user_updated_at=d["user_updated_at"]
          temp=Template.where("user_created_at = '"+c_user_created_at+"' and user_id = "+@user.id.to_s).first
          if (temp!=nil)
             temp.update(format: tempFormat,user_updated_at: DateTime.parse(c_user_updated_at),selected: tempSelected,name: tempName)
          end
      }
      #删除数据
      del.each{|d|
          tempName = d["name"]
          tempFormat = d["format"]
          tempSelected = d["selected"]
          c_user_created_at=d["user_created_at"]
          c_user_updated_at=d["user_updated_at"]
          temp=Template.where("user_created_at = '"+c_user_created_at+"' and user_id = "+@user.id.to_s).first
          if (temp!=nil)
             temp.delete()
          end
      }
      result ={
                "success" => "templates oprated successfully"
              }

      render :json => result
   end


   private   
       #通过session_id获取user对象
       def user_identify      
           userid=Rails.cache.read(params[:session_id])
           @user=nil
           @user=User.where(id: userid).first
           if(@user==nil)
               return str={"fail" => "session expired"}
           end
           return nil
   end
end
