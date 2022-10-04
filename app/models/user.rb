class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, uniqueness: true
  has_secure_password
end
