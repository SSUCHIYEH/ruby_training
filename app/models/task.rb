class Task < ApplicationRecord
    # belongs_to :user
    # belongs_to :tag
    enum status: [:NotStarted , :InProgress, :Compelete]
    enum priority: [:High , :Medium, :Low]
end
