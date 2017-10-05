require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
      @notification = notification.new(message: "Sorry about the error", email: "user@example.com")
  end
  
  test "should be valid" do
  assert @notification.valid?
end

test "message should be present" do
    @notification.message = ""
    assert_not @notification.valid?
end

test "email should be present" do
    @notification.email = " "
    assert_not @notification.valid?
end

end
