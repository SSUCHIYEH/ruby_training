class Task < ApplicationRecord
  # belongs_to :user
  # belongs_to :tag
  enum status: { NotStarted: 0, InProgress: 1, Compelete: 2 }
  enum priority: { High: 0, Medium: 1, Low: 2 }
end
