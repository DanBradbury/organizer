class WelcomeController < ApplicationController
    def index
      @sites = SiteManager.order("site_managers.order asc").find_all
    end
end
