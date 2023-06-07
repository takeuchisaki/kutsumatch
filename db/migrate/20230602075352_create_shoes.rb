class CreateShoes < ActiveRecord::Migration[6.1]
  def change
    create_table :shoes do |t|

      t.integer :customer_id, null: false
      t.string  :shoe_name,   null: false
      t.text    :body,        null: false
      t.string  :shoe_size,   null: false
      t.integer :price
      t.string  :match_rate,  null: false
      t.string  :tag_name

      t.timestamps
    end
  end
end
