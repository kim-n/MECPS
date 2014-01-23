class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :name, null: false
      t.string :description
      t.integer :user_id, null: false
      t.integer :book_id, null: false

      t.timestamps
    end
    add_index :questions, [:name, :book_id], unique: true
  end
end
