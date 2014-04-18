require 'google-search'

module SiteManagersHelper
  def return_images(str,num)
    images = []
    Google::Search::Image.new(:query => str, :image_size => :small).each do |image|
      images << image.uri if image.width < 200
      break if images.size == num
    end
    images
  end

  def parse_site(site_url)
    host = Addressable::URI.parse(site_url).host
    host = host.gsub("www.", "").gsub(/(\.[a-z]*)+/, "")
    host
  end

=begin
First Mechanize google crawler before I got smart and googled for the search api gem O_o
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
          if(q.include?(str))
            break if images.size>=num
            images << l if FastImage.size(l.url) == [200,200]
          end
        end
      end
    end

    images
  end
=end

=begin
Had a funny name so I gave it a shot and was severely disappointed with the image selection options
#ImageSuckr Too unreliable because of the random(results.size) zzz
    suckr = ImageSuckr::GoogleSuckr.new
    images = []

    while( images.size < num )
      url = suckr.get_image_url({"q" => str,   "imgsz" =>"icon"})
      #next if FastImage.size(url)[0]
      images << url
    end
    images
  end
=end

end
