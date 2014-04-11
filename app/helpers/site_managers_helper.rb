require 'rubygems'
require 'mechanize'
require 'fastimage'
module SiteManagersHelper
  def return_image
    return 'http://theplanetd.com/images/twitter_icon.png'
  end

  def return_images(str,num)
    get_request = 'http://images.google.com/images?q='
    get_request << str
    get_request << '&tbs=isz:ex,iszw:200,iszh:200'

    logger.debug "GET REQUEST: #{get_request}"

    agent = Mechanize.new #the money shot
    page = agent.get(get_request)
    images = []

    page.links.each do |link|
      begin
        clicked_page = link.click if link.uri.to_s.include? '/url?q'
      rescue Exception
        clicked_page = nil
      end


      if(clicked_page)
        clicked_page.images.each do |l|
          begin
            q = l.to_s
          rescue Exception
            next
          end
          if(( q.include?('.png') || q.include?('.jpg') ) && q.include?(str))
            break if images.size>=num
            images << l if FastImage.size(l.url) == [200,200]
          end
        end
      end
    end

    images
  end

end
