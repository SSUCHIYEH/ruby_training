class Task < ApplicationRecord
  # belongs_to :user
  # belongs_to :tag
  enum status: { notStarted: 0, inProgress: 1, complete: 2 }
  enum priority: { high: 0, medium: 1, low: 2 }
end
