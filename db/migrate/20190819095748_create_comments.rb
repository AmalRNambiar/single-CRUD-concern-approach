class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
    	t.integer :question_id
    	t.integer :user_id
    	t.text :text
    	t.string :ancestry

      t.timestamps
    end
    add_index :comments, :ancestry
  end
end
