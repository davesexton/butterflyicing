class ImageManagerController < ApplicationController
  def index
    @cats = get_gallery_categories
  end

  def upload
    @cats = get_gallery_categories
    unless params[:category]
      flash.now[:alert] = 'No category selected, file upload cancelled'
      render 'index'
    else
      img = params[:picture]
      cat = params[:category]
      cat = cat.to_s.scan(/\w+$/)[0]
      folder = Rails.root.join('app', 'assets', 'images', 'gallery', cat)
      file = Dir[folder.join('*.jpg')].map do |f|
        f.scan(/\d+/)[0].to_i + 1
      end.max.to_s + '.jpg'
      file = '1.jpg' unless file =~ /\d+/
      File.open(folder.join(file), 'wb') do |f|
        f.write(img.read)
      end
      flash.now[:notice] = 'File uploaded'
      render 'index'
    end
  end

end
