class CreateOptions < ActiveRecord::Migration[5.2]
  def change
    create_table :options do |t|
 			t.integer :question_id
      t.text :name

      t.timestamps
    end
  end
end
