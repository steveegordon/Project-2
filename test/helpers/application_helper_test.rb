require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,        "Steves App"
    assert_equal full_title("Help"), "Help | Steves App"
  end
end