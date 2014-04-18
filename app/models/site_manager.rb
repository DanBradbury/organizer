class SiteManager < ActiveRecord::Base
  #late night this feels too minimalistic (should be checking the host as well https:// will validate)
  validates :url,:format => URI::regexp(%w(http https))
end
