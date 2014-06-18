class AddUserTimeToTemplates < ActiveRecord::Migration
  def change
      add_column :templates, :user_created_at,:datetime
      add_column :templates, :user_updated_at,:datetime
  end
end
