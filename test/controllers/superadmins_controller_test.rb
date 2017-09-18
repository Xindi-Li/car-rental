require 'test_helper'

class SuperadminsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @superadmin = superadmins(:one)
  end

  test "should get index" do
    get superadmins_url
    assert_response :success
  end

  test "should get new" do
    get new_superadmin_url
    assert_response :success
  end

  test "should create superadmin" do
    assert_difference('Superadmin.count') do
      post superadmins_url, params: { superadmin: {  } }
    end

    assert_redirected_to superadmin_url(Superadmin.last)
  end

  test "should show superadmin" do
    get superadmin_url(@superadmin)
    assert_response :success
  end

  test "should get edit" do
    get edit_superadmin_url(@superadmin)
    assert_response :success
  end

  test "should update superadmin" do
    patch superadmin_url(@superadmin), params: { superadmin: {  } }
    assert_redirected_to superadmin_url(@superadmin)
  end

  test "should destroy superadmin" do
    assert_difference('Superadmin.count', -1) do
      delete superadmin_url(@superadmin)
    end

    assert_redirected_to superadmins_url
  end
end
