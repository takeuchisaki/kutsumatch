class CreateShoesComments < ActiveRecord::Migration[6.1]
  def change
    create_table :shoes_comments do |t|

      t.timestamps
    end
  end
end
