class AddTaskRefToUser < ActiveRecord::Migration[7.0]
  def change
    add_index :tasks, :user_id
  end
end
