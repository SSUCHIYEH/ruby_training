class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, uniqueness: true
  has_secure_password
  enum role: { normal: 0, manager: 1 }
end
