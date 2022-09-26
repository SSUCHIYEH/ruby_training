class Task < ApplicationRecord
  # belongs_to :user
  # belongs_to :tag
  default_scope -> { order(created_at: :desc) }
  enum status: { notStarted: 0, inProgress: 1, complete: 2 }
  enum priority: { high: 0, medium: 1, low: 2 }
  validates :end_time, comparison: { greater_than_or_equal_to: :start_time }
  validates :title, presence: true, allow_blank: false
end
