class ImageManagerController < ApplicationController
  def index
    @cats = get_gallery_categories
    #debugger
#TODO create hash for all images
    get_gallery_categories.map {|k, v| v }.each do |v|
      path = "./app/assets/images#{v}/*.jpg"
      #puts path
    end

    #path = "./app/assets/images/gallery/#{cat}/*.jpg"
    #@pics = Dir[path].sort_by{ |i| i.match('\d+')[0].to_i }.collect do |f|
    #  make_thumb f unless FileTest.exist?(f.sub('gallery', 'gallery_thumbnail'))
    #  idx = f.match('\d+')[0]
    #  pic = Hash.new(0)
    #  pic['thumb_url'] = "/assets/gallery_thumbnail/#{cat}/#{idx}.jpg"
    #  pic['image_url'] = "/assets/gallery/#{cat}/#{idx}.jpg"
    #  pic['sort'] = idx.to_i
    #  pic
    #end
  end

  def upload

    @cats = get_gallery_categories
    if params[:picture] and params[:category]

      img = params[:picture]
      if img.content_type  =~ /^image\/\w*(jpeg|png)\w*/
        require 'RMagick'

        if img.is_a?(StringIO)
          img = Magick::Image::from_blob(img.string).first
        else
          img = Magick::Image::read(img.local_path).first
        end

        cat = params[:category]
        cat = cat.to_s.scan(/\w+$/)[0]
        folder = Rails.root.join('app', 'assets', 'images', 'gallery', cat)
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
    render 'index'
  end

end
