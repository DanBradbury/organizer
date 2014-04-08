class SiteManagersController < ApplicationController
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
  end

  # POST /site_managers
  # POST /site_managers.json
  def create
    @site_manager = SiteManager.new(site_manager_params)

    respond_to do |format|
      if @site_manager.save
        format.html { redirect_to @site_manager, notice: 'Site manager was successfully created.' }
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
        format.html { redirect_to @site_manager, notice: 'Site manager was successfully updated.' }
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
    respond_to do |format|
      format.html { redirect_to site_managers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site_manager
      @site_manager = SiteManager.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def site_manager_params
      params.require(:site_manager).permit(:name, :url, :img)
    end
end
