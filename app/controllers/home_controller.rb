class HomeController < ApplicationController
  def index; end

  def status
    render json: {
      state: "ok",
      environment: Rails.env,
      checked_at: Time.current.iso8601
    }
  end

  def demo_data
    render json: {
      users: User.order(:id).map { |user|
        {
          id: user.id,
          name: user.name,
          email: user.email,
          role: user.role
        }
      },
      posts: Post.includes(:user).order(updated_at: :desc).map { |post|
        {
          id: post.id,
          title: post.title,
          body: post.body,
          author: post.user.name,
          published: post.published_at.present?,
          updated_at: post.updated_at.iso8601
        }
      }
    }
  end
end
