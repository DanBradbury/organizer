class SiteManagersController < ApplicationController
  include SiteManagersHelper
  before_action :set_site_manager, only: [:show, :edit, :update, :destroy]

  # GET /site_managers
  # GET /site_managers.json
  def index
    @site_managers = SiteManager.all
  end

  # GET /site_managers/1
  # GET /site_managers/1.json
  def show
  end

  # GET /site_managers/new
  def new
    @site_manager = SiteManager.new
  end

  # GET /site_managers/1/edit
  def edit
    $site = parse_site(@site_manager.url)
  end

  # POST /site_managers
  # POST /site_managers.json
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

  # PATCH/PUT /site_managers/1
  # PATCH/PUT /site_managers/1.json
  def update
    respond_to do |format|
      if @site_manager.update(site_manager_params)
        format.html { redirect_to root_path, notice: 'Site was successfully added..' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @site_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_managers/1
  # DELETE /site_managers/1.json
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

  def find_image
    num1 = params["num1"].to_i
    num2 = params["num2"].to_i
    # Do something with input parameter and respond as JSON with the output
    result = num1 + num2

    respond_to do |format|
      format.json {render :json => {:result => result}}
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
