class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.column :user_id,:integer,:null => false
      t.column :format,:string
      t.belongs_to :user
      t.timestamps
    end
  end
end
