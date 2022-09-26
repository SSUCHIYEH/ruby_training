class ChangeColumnOption < ActiveRecord::Migration[7.0]
  def change
    change_column_null :tasks, :title, false
    change_column_null :tasks, :status, false
    change_column_null :tasks, :priority, false
    change_column_null :tags, :name, false
    change_column_null :users, :name, false
    change_column_null :users, :password, false
    change_column_null :users, :role, false
  end
end
