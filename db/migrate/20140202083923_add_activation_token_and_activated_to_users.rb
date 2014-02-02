class AddActivationTokenAndActivatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_token, :string, null: false
    add_column :users, :activated, :boolean, default: false
  end
end
