require 'test_helper'

class AdminTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
      @admin = Admin.new(name: "Example User", email: "user@example.com")
  end
  
  test "should be valid" do
  assert @admin.valid?
end

test "name should be present" do
    @admin.name = ""
    assert_not @admin.valid?
end

test "email should be present" do
    @admin.email = " "
    assert_not @admin.valid?
end

test "email validation should reject invalid addresses" do
    invalid_addresses = %w[admin@example,com admin_at_foo.org admin.name@example.
    foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
        @admin.email = invalid_address
        assert_not @admin.valid?, "#{invalid_address.inspect} should be invalid"
    end
end

test "email addresses should be unique" do
    duplicate_superadmin = @admin.dup
    @admin.save
    assert_not duplicate_admin.valid?
end

end

