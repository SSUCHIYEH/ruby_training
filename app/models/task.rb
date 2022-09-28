class Task < ApplicationRecord
  # belongs_to :user
  # belongs_to :tag
  scope :sort_by_param, ->(order = nil, sort_by = nil) do
    if order && sort_by
      order("#{order} #{sort_by.upcase}")
    else
      order(created_at: :desc)
    end
  end
  enum status: { not_started: 0, in_progress: 1, complete: 2 }
  enum priority: { high: 0, medium: 1, low: 2 }
  validates :end_time, comparison: { greater_than_or_equal_to: :start_time }
  validates :title, presence: true, allow_blank: false
end
