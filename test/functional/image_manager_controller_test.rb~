require 'test_helper'

class ImageManagerControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test 'should upload file' do
    require 'fileutils'
    require 'RMagick'

#TODO add test for flash messages
    folder = Rails.root.join('app', 'assets', 'images', 'gallery', 'test')

# remove test category folder is exists and recreate
    FileUtils.rm_rf folder if Dir.exist?(folder)
    FileUtils.mkdir folder

# post upload and check page loads OK
    test_image = Rails.root.join('test', 'fixtures', 'files', 'test_image.jpg')
    file = Rack::Test::UploadedFile.new(test_image, "image/jpeg")
    post :upload, {picture: file, category: '/gallery/test'}
    assert_response :success
    assert_template :index
    assert_equal 1, Dir[File.join(folder, '*.jpg')].count

# post upload with large image
    test_image = Rails.root.join('test', 'fixtures', 'files', 'test_image_large.jpg')
    file = Rack::Test::UploadedFile.new(test_image, "image/jpeg")
    post :upload, {picture: file, category: '/gallery/test'}
    assert_equal 2, Dir[File.join(folder, '*.jpg')].count

# post uplaod with png image
    test_image = Rails.root.join('test', 'fixtures', 'files', 'test_image.png')
    file = Rack::Test::UploadedFile.new(test_image, "image/png")
    post :upload, {picture: file, category: '/gallery/test'}
    assert_equal 3, Dir[File.join(folder, '*.jpg')].count

# post upload with non image file
    test_image = Rails.root.join('test', 'fixtures', 'files', 'test_image.txt')
    file = Rack::Test::UploadedFile.new(test_image, "text/plain")
    post :upload, {picture: file, category: '/gallery/test'}
    assert_equal 3, Dir[File.join(folder, '*.jpg')].count

# check correct number of images in folder
    assert_not_nil Dir[folder.join('1.jpg')][0], 'missing first image'
    assert_not_nil Dir[folder.join('2.jpg')][0], 'missing second image'
    assert_not_nil Dir[folder.join('3.jpg')][0], 'missing third image'
    assert_nil Dir[folder.join('4.jpg')][0], 'Non image file created'

# check image sizes in test folder
  img = Magick::Image::read(folder.join('1.jpg')).first
  assert_equal 640, img.columns

  img = Magick::Image::read(folder.join('2.jpg')).first
  assert_equal 640, img.columns

  img = Magick::Image::read(folder.join('3.jpg')).first
  assert_equal 640, img.columns

# remove test folder
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
