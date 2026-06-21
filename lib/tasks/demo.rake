namespace :demo do
  desc "顯示使用者與文章統計"
  task stats: :environment do
    puts "使用者：#{User.count}"
    puts "文章：#{Post.count}"
    puts "已發布：#{Post.where.not(published_at: nil).count}"
    puts "草稿：#{Post.where(published_at: nil).count}"
  end

  desc "建立一篇示範文章"
  task create_post: :environment do
    user = User.order(:id).first

    abort "找不到使用者，請先執行 bin/rails db:seed" unless user

    post = Post.find_or_initialize_by(slug: "rake-task-demo")
    post.update!(
      user: user,
      title: "Rake Task 示範文章",
      body: "這篇文章由 demo:create_post task 建立。",
      published_at: nil
    )

    puts "示範文章已準備完成：#{post.title}"
  end

  desc "發布目前所有草稿"
  task publish_drafts: :environment do
    drafts = Post.where(published_at: nil)
    count = drafts.update_all(published_at: Time.current, updated_at: Time.current)

    puts "已發布 #{count} 篇草稿。"
  end

  desc "確保預設管理員帳號存在"
  task ensure_admin: :environment do
    admin = User.find_or_initialize_by(email: "admin@example.com")
    admin.update!(name: "系統管理員", role: "admin")

    puts "管理員帳號已準備完成：#{admin.email}"
  end
end
