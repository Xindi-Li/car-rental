class User < ApplicationRecord
  validates :email,:name,:password,:authority, presence: true
  validates :password, length: { in: 3..20 }
  validates :email, uniqueness: true
  has_secure_password
end
