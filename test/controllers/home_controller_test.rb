require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "renders the Vue mount point" do
    get root_url

    assert_response :success
    assert_select "#vue-app"
  end

  test "returns application status" do
    get api_status_url, as: :json

    assert_response :success
    assert_equal "ok", response.parsed_body["state"]
    assert_equal "test", response.parsed_body["environment"]
  end
end
