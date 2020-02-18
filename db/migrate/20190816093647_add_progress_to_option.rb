class AddProgressToOption < ActiveRecord::Migration[5.2]
  def change
  	add_column :options, :progress, :float, default: 0
  end
end
