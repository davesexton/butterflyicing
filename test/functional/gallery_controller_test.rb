require 'test_helper'

class GalleryControllerTest < ActionController::TestCase

  test 'should get index' do
    get :index
    assert_redirected_to gallery_path(Tag.first.id)
  end

end
