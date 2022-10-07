class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name, uniqueness: true
  has_secure_password
  enum role: { normal: 0, admin: 1 }
  before_destroy :check_last_admin

  private

  def check_last_admin
    throw(:abort) if (User.admin.count == 1) && admin?
  end
end
