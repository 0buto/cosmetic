require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get contacts" do
    get pages_contacts_url
    assert_response :success
  end
end
