class Superadmin < ApplicationRecord
  validates :username,:password, presence: true
  has_secure_password
end
