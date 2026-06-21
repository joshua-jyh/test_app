module Demo
  class PostContentGenerator
    SUBJECTS = %w[
      部署流程
      排程任務
      資料同步
      Rails\ 服務
      Vue\ 介面
      測試環境
    ].freeze

    ACTIONS = %w[
      完成了一次自動更新
      正在確認資料庫連線
      已通過例行健康檢查
      產生了新的展示內容
      成功執行背景工作
      回報目前運作正常
    ].freeze

    DETAILS = %w[
      使用者與文章資料都可以正常讀取。
      這段文字來自獨立的隨機字庫。
      頁面重新整理後即可看到最新結果。
      本次執行沒有使用固定文章內容。
      updated_at\ 也會同步反映執行時間。
      這是一段僅供整合環境展示的內容。
    ].freeze

    def self.generate(at: Time.current)
      "#{SUBJECTS.sample}#{ACTIONS.sample}。#{DETAILS.sample} 更新時間：#{at.iso8601}"
    end
  end
end
