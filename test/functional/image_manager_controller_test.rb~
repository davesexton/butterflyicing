require 'test_helper'

class ImageManagerControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test 'should upload file' do
    require 'fileutils'

    folder = Rails.root.join('app', 'assets', 'images', 'gallery', 'test')

    FileUtils.rm_rf folder if Dir.exist?(folder)
    FileUtils.mkdir folder

    test_image = Rails.root.join('test', 'fixtures', 'files', 'test_image.jpg')
    file = Rack::Test::UploadedFile.new(test_image, "image/jpeg")
    post :upload, {picture: file, category: '/gallery/test'}
    assert_response :success
    assert_equal 1, Dir[File.join(folder, '*.jpg')].count, "no"
    assert_template :index

    FileUtils.rm_rf folder

  end

  test 'should handle no category selected' do
    test_image = Rails.root.join('test', 'fixtures', 'files', 'test_image.jpg')
    file = Rack::Test::UploadedFile.new(test_image, "image/jpeg")
    post :upload, {picture: nil, category: nil}
    assert_response :success
    assert_template :index
  end

  test 'should handle no image selected' do
    post :upload, {picture: nil, category: '/gallery/birthday'}
    assert_response :success
    assert_template :index
  end

end
