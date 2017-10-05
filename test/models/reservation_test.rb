require 'test_helper'

class ReservationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
      @reservation = reservation.new(lpn: "1234567", email: "user@example.com")
  end
  
  test "should be valid" do
  assert @reservation.valid?
end

test "lpn should be present" do
    @reservation.lpn = ""
    assert_not @reservation.valid?
end

test "email should be present" do
    @reservation.email = " "
    assert_not @reservation.valid?
end

end
