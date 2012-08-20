require 'test_helper'

class GalleryControllerTest < ActionController::TestCase
#TODO add test for thumbnail creation
  test "should get index" do
    get :index
    assert_response :success
  end

end
