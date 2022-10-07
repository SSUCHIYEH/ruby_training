class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, uniqueness: true
  has_secure_password
  enum role: { normal: 0, admin: 1 }
  before_destroy do
    throw(:abort) if (User.where(role: 'admin').count == 1) && (role == 'admin')
  end
end
