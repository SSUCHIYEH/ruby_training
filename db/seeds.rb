# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'factory_bot'
require './spec/factories/task'
require './spec/factories/user'

if Task.all.empty?
  FactoryBot.create_list(:task, 4, :init)
  FactoryBot.create_list(:task, 4, :init, :important)
  FactoryBot.create_list(:task, 4, :complete)
end

FactoryBot.create(:user, :first) if User.all.empty?

if !Task.where.missing(:user).empty?
  @user = User.all.first 
  @tasks = Task.where.missing(:user)
  @tasks.each do |task|
    task.update_attribute(:user_id, @user.id)
  end
end
