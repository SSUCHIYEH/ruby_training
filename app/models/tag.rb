class Tag < ApplicationRecord
  has_many :tags_tasks, dependent: :destroy
  has_many :takes, through: :tags_tasks
end
