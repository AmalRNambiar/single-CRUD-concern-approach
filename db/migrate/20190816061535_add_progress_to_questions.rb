class AddProgressToQuestions < ActiveRecord::Migration[5.2]
  def change
  	add_column :questions, :progress, :float, default: 0
  end
end
