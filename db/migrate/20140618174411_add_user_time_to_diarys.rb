class AddUserTimeToDiarys < ActiveRecord::Migration
  def change
     add_column :diarys,:user_created_at,:datetime
     add_column :diarys,:user_updated_at,:datetime
  end
end
