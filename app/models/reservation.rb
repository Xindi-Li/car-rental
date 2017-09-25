class Reservation < ApplicationRecord
	validates :lpn, :email, :expect_start_time, :expect_return_time, presence:true
	# validates :expect_start_time, :expect_return_time, numericality:{greater_than:Time.now}
end
