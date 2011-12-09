class RemoveWorkers < ActiveRecord::Migration
  def up
    drop_table :workers
  end

  def down
    t.string   :name
    t.string   :website
    t.string   :street
    t.string   :postal_code
    t.string   :city
    t.float    :latitude
    t.float    :longitude

    t.timestamps
  end
end
