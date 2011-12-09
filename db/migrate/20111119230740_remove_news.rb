class RemoveNews < ActiveRecord::Migration
  def up
    drop_table :news
  end

  def down
    create_table :news do |t|
      t.references  :user
      t.string      :title
      t.text        :description
      t.string      :slug
      t.integer     :comments_count, :default => 0
      
      t.timestamps
    end
  end
end
