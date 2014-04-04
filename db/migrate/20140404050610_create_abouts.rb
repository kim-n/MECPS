class CreateAbouts < ActiveRecord::Migration
  def change
    create_table :abouts do |t|
      t.text :page_html 
      
      t.timestamps
    end
  end
end
