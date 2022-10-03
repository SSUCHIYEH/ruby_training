class UpdateTasksUserId < ActiveRecord::Migration[7.0]
  def change
    Task.where.missing(:user).each { |t| t.update!(user_id: User.first.id) }
  end
end
