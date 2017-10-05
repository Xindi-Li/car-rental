require 'test_helper'

class SuperadminTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
      @superadmin = Superadmin.new(name: "Example User", email: "user@example.com")
  end
  
  test "should be valid" do
      assert @superadmin.valid?
  end

  test "name should be present" do
      @superadmin.name = ""
      assert_not @superadmin.valid?
  end

  test "email should be present" do
      @superadmin.email = " "
      assert_not @superadmin.valid?
  end

  test "email validation should reject invalid addresses" do
      invalid_addresses = %w[superadmin@example,com superadmin_at_foo.org superadmin.name@example.
      foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
          @superadmin.email = invalid_address
          assert_not @superadmin.valid?, "#{invalid_address.inspect} should be invalid"
      end
  end

  test "email addresses should be unique" do
      duplicate_superadmin = @superadmin.dup
      @superadmin.save
      assert_not duplicate_superadmin.valid?
  end

end
