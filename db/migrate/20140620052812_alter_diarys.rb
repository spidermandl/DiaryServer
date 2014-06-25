class AlterDiarys < ActiveRecord::Migration
  def up
     rename_table("diarys","diaries")
  end

  def down
     rename_table("diaries","diarys")
  end
end
