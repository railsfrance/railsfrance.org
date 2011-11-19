class AddAdapterNameToEvent < ActiveRecord::Migration
  def change
    add_column :events, :adapter_name, :string
  end
end
