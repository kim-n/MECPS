class AddParentIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :parent_id, :integer, default: 0
  end
end