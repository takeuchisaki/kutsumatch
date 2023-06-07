class CreateShoeTags < ActiveRecord::Migration[6.1]
  def change
    create_table :shoe_tags do |t|
      t.integer :shoe_id
      t.integer :tag_id

      t.timestamps
    end
    # 同じタグを２回保存することが出来ないようにする
    add_index :shoe_tags, [:shoe_id, :tag_id], unique: true
  end
end
