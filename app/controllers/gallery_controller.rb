class GalleryController < ApplicationController
  skip_before_filter :authorize

  def index
    cat = params[:cat] ? params[:cat] : 'birthday'
    path = './app/assets/images/gallery/**'

    @cats = Hash[*Dir[path].sort.collect do |d|
      x = d.match('\w+$')[0]
      [x.capitalize, "/gallery/#{x}"]
    end.flatten]

    @cats_selected = cat

    path = "./app/assets/images/gallery/#{cat}/*.jpg"

    @pics = Dir[path].sort_by{ |i| i.match('\d+')[0].to_i }.collect do |f|
      make_thumb f unless FileTest.exist?(f.sub('gallery', 'gallery_thumbnail'))
      idx = f.match('\d+')[0]
      pic = Hash.new(0)
      pic['thumb_url'] = "/assets/gallery_thumbnail/#{cat}/#{idx}.jpg"
      pic['image_url'] = "/assets/gallery/#{cat}/#{idx}.jpg"
      pic['sort'] = idx.to_i
      pic
    end
  end

  private
  def make_thumb path
    require 'RMagick'
    thumb = path.sub('gallery', 'gallery_thumbnail')
    img = Magick::Image::read(path).first
    img = img.crop_resized!(75, 75, Magick::NorthGravity)
    #img = img.thumbnail(0.36)
    img.write(thumb)
  end
end
