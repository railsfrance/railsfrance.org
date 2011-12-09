class RemoveGuides < ActiveRecord::Migration
  def up
    drop_table :guides
  end

  def down
    create_table :guides do |t|
      t.string :name
      t.string :description
      t.string :website

      t.timestamps
    end
  end
end
