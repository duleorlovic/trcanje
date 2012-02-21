class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :users_id

      t.timestamps
    end
    add_index :microposts,[:users_id, :created_at]
  end
end
