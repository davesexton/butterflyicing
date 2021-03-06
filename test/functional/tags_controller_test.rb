require 'test_helper'

class TagsControllerTest < ActionController::TestCase
  setup do
    @tag = tags(:one)
    @tag_no_images = tags(:tag_no_images)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tag" do
    assert_difference('Tag.count') do
      post :create, tag: { tag_group_id: @tag.tag_group_id, title: @tag.title }
    end

    assert_redirected_to tags_path
  end

  test "should show tag" do
    get :show, id: @tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tag
    assert_response :success
  end

  test "should update tag" do
    put :update, id: @tag, tag: { tag_group_id: @tag.tag_group_id, title: @tag.title }
    assert_redirected_to tags_path
  end

  test "should destroy tag" do
    assert_difference('Tag.count', -1) do
      delete :destroy, id: @tag_no_images
    end

    assert_redirected_to tags_path
  end
end
