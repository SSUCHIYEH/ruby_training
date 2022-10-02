class AddTaskRefToUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :tasks, :user_id
    add_reference :tasks, :user, index: true
  end
end
