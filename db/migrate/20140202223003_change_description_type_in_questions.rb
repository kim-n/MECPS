class ChangeDescriptionTypeInQuestions < ActiveRecord::Migration
  def change
    change_column :questions, :description, :text
  end
end
