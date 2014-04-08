require 'test_helper'

class SiteManagersControllerTest < ActionController::TestCase
  setup do
    @site_manager = site_managers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:site_managers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create site_manager" do
    assert_difference('SiteManager.count') do
      post :create, site_manager: { img: @site_manager.img, name: @site_manager.name, url: @site_manager.url }
    end

    assert_redirected_to site_manager_path(assigns(:site_manager))
  end

  test "should show site_manager" do
    get :show, id: @site_manager
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @site_manager
    assert_response :success
  end

  test "should update site_manager" do
    patch :update, id: @site_manager, site_manager: { img: @site_manager.img, name: @site_manager.name, url: @site_manager.url }
    assert_redirected_to site_manager_path(assigns(:site_manager))
  end

  test "should destroy site_manager" do
    assert_difference('SiteManager.count', -1) do
      delete :destroy, id: @site_manager
    end

    assert_redirected_to site_managers_path
  end
end
