class Car < ApplicationRecord
	# has_many :reservations
	mount_uploader :img_attach, CarImageUploader
	validates :lpn, :manufactuere, :model, :hrr, :style, :location, presence: true
	validates :lpn, uniqueness: true
	validates :hrr, numericality:{greater_than: 0.0}
	validates :status, inclusion:{in:['Reserved', 'Checkout', 'Available']}


    def reserve lpn
	    @lpn = lpn
	    @car = Car.find(:lpn)
	    if @car.status == "available"
	      @car.status = "reserved"
	      true
	    else
	      false
	    end
    end
end
