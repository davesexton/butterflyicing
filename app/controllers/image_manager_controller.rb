class ImageManagerController < ApplicationController
  def index
    @cats = get_gallery_categories

    #path = "./app/assets/images/gallery/**/*.jpg"
    path = Rails.root.join('public', 'gallery', '**', '*.jpg')
    @pics = get_all_pics

  end

  def upload

    @cats = get_gallery_categories
    @pics = get_all_pics

    if params[:picture] and params[:category]

      img = params[:picture]
      if img.content_type  =~ /^image\/\w*(jpeg|png)\w*/
        require 'RMagick'
        require 'fileutils'

        img.rewind
        img = Magick::Image::from_blob(img.read).first

        cat = params[:category]
        cat = cat.to_s.scan(/\w+$/)[0]
        #folder = Rails.root.join('app', 'assets', 'images', 'gallery', cat)
        folder = Rails.root.join('public', 'gallery', cat)
        file = Dir[folder.join('*.jpg')].map do |f|
          f.scan(/\d+/)[0].to_i + 1
        end.max.to_s + '.jpg'
        file = '1.jpg' unless file =~ /\d+/
        img.change_geometry!('640x480') { |cols, rows, img|
          img.resize!(cols, rows)
        }
        img.write(folder.join(file))
        flash.now[:notice] = 'File uploaded'
      else
        flash.now[:alert] = 'Only image file files allowed, file upload cancelled'
      end
    else
      flash.now[:alert] = 'No category or file selected, file upload cancelled'
    end
    #render 'index'
    redirect_to image_manager_path
  end

  def delete
    path = Rails.root.join('public')
    img = params[:image_url].match('(?<=/)\d+\.jpg$')[0]
    cat = params[:image_url].match('(?<=/)\w+(?=/\d+\.jpg)')[0]
    #File.delete(path.join('gallery').join(cat).join(img))
    #File.delete(path.join('gallery_thumbnail').join(cat).join(img))

    File.delete(path.join('gallery', cat, img))
    File.delete(path.join('gallery_thumbnail', cat, img))

    redirect_to image_manager_path, notice: 'Image deleted'
  end

end
