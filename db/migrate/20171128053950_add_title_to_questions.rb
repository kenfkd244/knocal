class AddTitleToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :title, :text, null: false
  end
end
