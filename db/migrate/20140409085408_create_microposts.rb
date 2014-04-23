class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id

      # t.timestamps will created fields: created_at & updated_at
      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at]
  end
end
