class Car < ApplicationRecord
  # has_many :reservations
  mount_uploader :img_attach, CarImageUploader
  validates :lpn, :manufactuere, :model, :hrr, :style, :location, presence: true
  validates :lpn, uniqueness: true, numericality: { only_integer: true }, length: { is: 7 }
  validates :hrr, numericality: {greater_than: 0.0}
  validates :status, inclusion: {in: ['Reserved', 'Checkout', 'Available']}
  validates :style, inclusion: {in: ['Coupe', 'Sedan', 'SUV']}

end
