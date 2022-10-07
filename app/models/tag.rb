class Tag < ApplicationRecord
  has_many :tags_tasks, dependent: :destroy
  has_many :tasks, through: :tags_tasks
end
