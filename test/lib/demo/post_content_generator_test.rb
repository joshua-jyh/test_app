require "test_helper"

class Demo::PostContentGeneratorTest < ActiveSupport::TestCase
  test "generates demo content with the execution time" do
    execution_time = Time.zone.parse("2026-06-22 12:34:56")
    content = Demo::PostContentGenerator.generate(at: execution_time)

    assert_includes content, execution_time.iso8601
    assert_operator content.length, :>, 30
  end
end
