class AddPaperclipSourceToBooks < ActiveRecord::Migration
  def change
    remove_column :books, :source
    add_attachment :books, :source
  end
end
