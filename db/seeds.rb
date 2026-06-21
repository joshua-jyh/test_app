users = [
  { name: "王小明", email: "ming@example.com", role: "admin" },
  { name: "陳美玲", email: "meiling@example.com", role: "editor" },
  { name: "林志豪", email: "zhihao@example.com", role: "member" }
].index_by { |attributes| attributes.fetch(:email) }

users.each_value do |attributes|
  User.find_or_initialize_by(email: attributes.fetch(:email)).update!(attributes)
end

posts = [
  {
    user_email: "ming@example.com",
    title: "歡迎來到測試網站",
    slug: "welcome-to-the-test-site",
    body: "這是一篇用 seed 建立的歡迎文章，可以自由修改或刪除。",
    published_at: 3.days.ago
  },
  {
    user_email: "ming@example.com",
    title: "Rails 開發環境筆記",
    slug: "rails-development-notes",
    body: "記錄資料庫 migration、seed 與日常開發流程。",
    published_at: 2.days.ago
  },
  {
    user_email: "meiling@example.com",
    title: "本週功能更新",
    slug: "weekly-feature-update",
    body: "本週新增文章與使用者資料表，並準備了一些範例資料。",
    published_at: 1.day.ago
  },
  {
    user_email: "meiling@example.com",
    title: "介面改善草稿",
    slug: "interface-improvement-draft",
    body: "整理下一版介面預計調整的項目，目前尚未發布。",
    published_at: nil
  },
  {
    user_email: "zhihao@example.com",
    title: "第一次使用心得",
    slug: "first-use-impressions",
    body: "測試帳號建立的第一篇文章，內容僅供開發環境使用。",
    published_at: 6.hours.ago
  },
  {
    user_email: "zhihao@example.com",
    title: "待辦事項",
    slug: "project-todo-list",
    body: "補測試、整理文件，並確認部署環境的資料庫設定。",
    published_at: nil
  }
]

users_by_email = User.where(email: users.keys).index_by(&:email)

posts.each do |attributes|
  user = users_by_email.fetch(attributes.fetch(:user_email))
  post_attributes = attributes.except(:user_email).merge(user: user)

  Post.find_or_initialize_by(slug: attributes.fetch(:slug)).update!(post_attributes)
end

puts "Seeded #{User.count} users and #{Post.count} posts."
