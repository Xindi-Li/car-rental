require 'test_helper'

class CarTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
      @car = Car.new(lpn: "1234567", model: "aswedf", location: "NCState")
  end
  
  test "should be valid" do
    assert @car.valid?
  end

  test "lpn should be present" do
    @car.lpn = ""
    assert_not @car.valid?
  end

  test "model should be present" do
    @car.model = " "
    assert_not @car.valid?
  end

  test "location should be present" do
    @car.location = " "
    assert_not @car.valid?
  end

end
