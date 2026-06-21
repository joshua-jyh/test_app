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

  test "returns users and posts for the demo dashboard" do
    user = User.create!(name: "測試使用者", email: "demo@example.com", role: "editor")
    post = user.posts.create!(
      title: "測試文章",
      slug: "demo-post",
      body: "展示內容",
      published_at: Time.current
    )

    get api_demo_data_url, as: :json

    assert_response :success
    assert_equal user.email, response.parsed_body["users"].first["email"]
    assert_equal post.body, response.parsed_body["posts"].first["body"]
    assert_equal user.name, response.parsed_body["posts"].first["author"]
    assert response.parsed_body["posts"].first["published"]
  end
end
