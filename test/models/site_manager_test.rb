require 'test_helper'

class SiteManagerTest < ActiveSupport::TestCase
  test "blank manger is invalid" do
    manager = SiteManager.new :img => 'na'
    assert !manager.valid?
  end
end
