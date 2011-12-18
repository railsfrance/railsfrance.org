class RemoveComments < ActiveRecord::Migration
  def up
    drop_table :comments
  end

  def down
    create_table "comments" do |t|
      t.integer  "user_id"
      t.integer  "commentable_id"
      t.string   "commentable_type"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end
  end
end
