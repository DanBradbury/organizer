require 'test_helper'

class SiteManagersHelperTest < ActionView::TestCase
  test "return valid image list" do
    images = return_images("twitter", 3)
    assert_equal images.size, 3
    images.each do |g|
      assert g =~ URI::regexp
    end
  end

  test "return image with bad link" do
    assert_equal [], return_images('nts2326sSD$&#$*DKSLDSFUYE*#^$Kss', 1) #was using omniref until I complained to maintainer and he uploaded images
  end

  test "parse site from url" do
    assert_equal 'twitter', parse_site('https://twitter.com/')
    assert_equal 'google', parse_site('https://www.google.com/')
  end
end
