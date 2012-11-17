class AddDefaultSateToJob < ActiveRecord::Migration
  def change
    change_column :jobs, :state, :string, default: 'pending'
  end
end
