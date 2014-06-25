class ChangeDiariesContent < ActiveRecord::Migration
  def change
      reversible do |dir|
        change_table :diaries do |t|
          dir.up { t.change :content, :text }
          dir.down { t.change :content, :string }
        end
      end
  end
end
