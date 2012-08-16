require 'test_helper'

class ImageManagerControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test 'should upload file' do
    folder = Rails.root.join('app', 'assets', 'images', 'gallery', 'test')
    if Dir.exist?(folder)
      Dir[File.join(folder, '*.*')].each{ |f| File.delete(f) }
    else
      Dir.mkdir(folder)
    end
    test_image = Rails.root.join('test', 'fixtures', 'files', 'test_image.jpg')
    file = Rack::Test::UploadedFile.new(test_image, "image/jpeg")
    post :upload, {picture: file, category: '/gallery/test'}
    assert_response :success
    assert_equal 1, Dir[File.join(folder, '*.jpg')].count, "no"
    assert_template :index
    Dir[File.join(folder, '*.*')].each{ |f| File.delete(f) }
    while Dir[File.join(folder, '*.*')].count > 0
    end
    Dir.rmdir(folder)



    #target_folder = Rails.root.join('app', 'assets', 'images', 'gallery', 'test', '*.jpg')
    #target_count = Dir[File.join(target_folder)].count
    #test_image = Rails.root.join('test', 'fixtures', 'files', 'test_image.jpg')
    #file = Rack::Test::UploadedFile.new(test_image, "image/jpeg")
    #post :upload, {picture: file, category: '/gallery/birthday'}
    #assert_response :success
    #assert_equal target_count + 1,
    #             Dir[File.join(target_folder)].count
    #assert_response :success
    #assert_template :index
    #File.delete(Dir['./app/assets/images/gallery/birthday/*.jpg'].sort_by{ |f| File.mtime(f) }.last)
  end

end