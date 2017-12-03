class AddColumnsToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :lat, :float
    add_column :questions, :lng, :float
  end
end
