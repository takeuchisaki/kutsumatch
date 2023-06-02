class CreateKeeps < ActiveRecord::Migration[6.1]
  def change
    create_table :keeps do |t|

      t.timestamps
    end
  end
end
