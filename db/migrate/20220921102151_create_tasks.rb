class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :content
      t.date :start_time
      t.date :end_time
      t.integer :status
      t.integer :priority
      t.integer :tag_id
      t.integer :user_id
    end
  end
end
