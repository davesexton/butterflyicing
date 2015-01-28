require 'test_helper'

class GalleryImagesControllerTest < ActionController::TestCase
  setup do
    @gallery_image = gallery_images(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gallery_images)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gallery_image" do
    assert_difference('GalleryImage.count') do
      image = fixture_file_upload('files/test_image.jpg', 'image/jpeg')
      post :create, gallery_image: { tag_id: @gallery_image.tag_id, image: image }
    end

    assert_redirected_to gallery_images_path
  end

  test "should show gallery_image" do
    get :show, id: @gallery_image
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gallery_image
    assert_response :success
  end

  test "should update gallery_image" do
    put :update, id: @gallery_image, gallery_image: { tag_id: @gallery_image.tag_id }
    assert_redirected_to gallery_images_path
  end

  test "should destroy gallery_image" do
    assert_difference('GalleryImage.count', -1) do
      delete :destroy, id: @gallery_image
    end

    assert_redirected_to gallery_images_path
  end
end
