class Reservation < ApplicationRecord
	validates :lpn, :email, :expect_start_time, :expect_return_time, presence:true
	# validates :expect_start_time, :expect_return_time, numericality:{greater_than:Time.now}

	validate :timeValidation
	def timeValidation
		if expect_start_time < Time.now || expect_start_time > Time.now + 7.days
      Rails.logger.info "time : #{expect_start_time} ---- #{Time.now}"
			errors.add(:expect_start_time, "should be within 7 days from now")
		elsif  expect_return_time < Time.now || expect_return_time <= expect_start_time
			errors.add(:expect_return_time, "should be later than expect start time!")
		elsif expect_return_time - expect_start_time > 10.hours
			errors.add(:expect_return_time, :expect_start_time, "Total rental time should be no more than 10 hours.")
		end
	end
				
				
end
