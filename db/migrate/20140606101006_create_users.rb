class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.column :username,:string,:null => false
      t.column :passwd,:string,:null=>false
      t.column :email,:string
      t.column :nickname,:string
      t.column :portrait_link,:string
      t.timestamps
    end
  end
end
