class ChangeTemplatesContent < ActiveRecord::Migration
  def change
      reversible do |dir|
        change_table :templates do |t|
           dir.up {t.change :format,:text }
           dir.down { t.change :format, :string}
        end
      end
  end
end
