class Notification < ApplicationRecord
  validates :email,:message, presence:true
end
