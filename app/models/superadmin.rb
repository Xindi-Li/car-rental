class Superadmin < ApplicationRecord
  validates :username,:password, presence: true
end
