set :output, {
  standard: "log/cron.log",
  error: "log/cron_error.log"
}

every 1.hour do
  rake "demo:stats"
end

every 1.day, at: "1:30 am" do
  rake "demo:ensure_admin"
end

every 1.day, at: "8:00 am" do
  rake "demo:publish_drafts"
end

every :monday, at: "9:00 am" do
  rake "demo:create_post"
end
