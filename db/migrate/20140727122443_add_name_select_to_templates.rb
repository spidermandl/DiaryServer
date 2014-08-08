class AddNameSelectToTemplates < ActiveRecord::Migration
  def change
    add_column :templates, :name, :string
    add_column :templates, :selected, :decimal
  end
end
