class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.text :page_html 

      t.timestamps
    end
  end
end
