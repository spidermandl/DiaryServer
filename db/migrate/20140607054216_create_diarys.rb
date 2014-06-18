class CreateDiarys < ActiveRecord::Migration
  def change
    create_table :diarys do |t|
     t.column :user_id,:integer,:null =>false
     t.column :content,:string
     t.belongs_to :user
     t.timestamps
    end
  end
end
