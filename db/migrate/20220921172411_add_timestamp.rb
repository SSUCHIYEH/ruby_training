class AddTimestamp < ActiveRecord::Migration[7.0]
  def change
    add_column :tags, :created_at, :datetime, null: false
    add_column :tags, :updated_at, :datetime, null: false
    add_column :tasks, :created_at, :datetime, null: false
    add_column :tasks, :updated_at, :datetime, null: false
    add_column :users, :created_at, :datetime, null: false
    add_column :users, :updated_at, :datetime, null: false
  end
end
