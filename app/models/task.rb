class Task < ApplicationRecord
  belongs_to :user
  has_many :tags_tasks, dependent: :destroy
  has_many :tags, through: :tags_tasks
  scope :sort_by_param, ->(order = nil, sort_by = nil) do
    if order && sort_by
      order("#{order} #{sort_by.upcase}")
    else
      order(created_at: :desc)
    end
  end
  scope :search_by_param, ->(title = nil, status = nil) do
    if title.blank? && status.blank?
      all
    elsif title.blank? && status.present?
      where("status = ?", status)
    elsif title.present? && status.blank?
      where("title ~* ?", title)
    else
      where("title ~* ?", title).where("status = ?", status)
    end
  end
  scope :search_by_tag, ->(tag_id = nil) do
    if tag_id.blank?
      all
    else
      includes(:tags).where(tags: { id: tag_id })
    end
  end
  enum status: { not_started: 0, in_progress: 1, complete: 2 }
  enum priority: { low: 0, medium: 1, high: 2 }
  validates :end_time, comparison: { greater_than_or_equal_to: :start_time }
  validates :title, presence: true, allow_blank: false
  paginates_per 10
end
