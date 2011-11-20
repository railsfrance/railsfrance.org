class AddApiIdAndChangeAdapterNameToEvent < ActiveRecord::Migration
  def change
    add_column :events, :api_id, :integer
    remove_column :events, :adapter_name
    add_column :events, :api_name, :string
  end
end
