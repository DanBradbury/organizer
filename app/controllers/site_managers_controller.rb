class SiteManagersController < ApplicationController
  include SiteManagersHelper
  before_action :set_site_manager, only: [:show, :edit, :update, :destroy]


  def new
    @site_manager = SiteManager.new
  end

  def edit
    $site = parse_site(@site_manager.url)
  end

  def create
    @site_manager = SiteManager.new(site_manager_params)
    @site_manager.order = SiteManager.count(:all)

    respond_to do |format|
      if @site_manager.save
        format.html { redirect_to edit_site_manager_path(@site_manager), notice: 'Site manager was successfully created.' }
        format.js {}
        format.json { render action: 'show', status: :created, location: @site_manager }
      else
        format.html { render action: 'new' }
        format.json { render json: @site_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @site_manager.update(site_manager_params)
        format.html { redirect_to root_path, notice: 'Site was successfully updated' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @site_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @site_manager.destroy
    reset_order
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Site Successfully Removed' }
      format.json { head :no_content }
    end
  end

  def reset_order
    @sites = SiteManager.order("site_managers.order asc").find_all
    i = 0
    @sites.each do |f|
      f.order = i
      f.save
      i += 1
    end
  end

  def move_item
    set_site_manager
    order = @site_manager.order
    if params[:direction] == "left"
      replacement = SiteManager.find_by_order(order-1)
      @site_manager.order = order - 1
      replacement.order = order
    else #too general for move to front/back but will work for now
      replacement = SiteManager.find_by_order(order+1)
      @site_manager.order = order + 1
      replacement.order = order
    end
    @site_manager.save
    replacement.save

    respond_to do |format|
      format.js {render js: "location.reload();"}
    end
  end

  def search_images
    @images = return_images($site, 5)
    i = 1
    str = ''
    @images.each do |f|
      str << "<div class=\"image_selector\" data-img-num=\"#{i}\"><img src=\"#{f.to_s}\"></div>"
      i += 1
    end

    respond_to do |format|
      format.js { render js: "$('#images').html('#{str}');" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site_manager
      @site_manager = SiteManager.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_manager_params
      params.require(:site_manager).permit(:name, :url, :img, :order)
    end
end
