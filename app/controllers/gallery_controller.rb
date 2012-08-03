class GalleryController < ApplicationController
  def index
    path = './app/assets/images/gallery/'

#    @options = Dir["#{path}**/1.jpg"].collect do |f|
#      t = f.sub('gallery', 'gallery_thumbnail')
#      make_thumb f unless FileTest.exist?(t)
#      pic = Hash.new(0)
#      cat = f.sub(path, '').sub('/1.jpg', '')
#      #pic['image_url'] = t.sub('./app', '').sub('/images', '')
#      pic['link'] = "/gallery/#{cat}"
#      pic['category'] = cat.capitalize
#      pic
#    end

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

  def show
    cat = params[:cat]
    path = "./app/assets/images/gallery/#{cat}/*.jpg"
    files = Dir[path].sort_by{ |i| i.match('\d+')[0].to_i }

    if params[:id]
      id = params[:id]
      img = "./app/assets/images/gallery/#{cat}/#{id}.jpg"

      @links = Hash.new(0)
      @links[:current] = img
      @links[:next] = files[files.find_index(img) + 1]
      @links[:prev] = files.find_index(img) == 0 ? nil : files[files.find_index(img) - 1]
      @links[:first] = files[0]
      @links[:last] = files[files.count - 1]
      @links.each do |k, v|
        @links[k] = v.nil? ? nil : "/gallery/#{cat}/#{v.match('\d+')}"
      end
      @pic = "/assets/gallery/#{cat}/#{id}.jpg"
      render partial: 'image_viewer'
    else
      @pics = Dir[path].collect do |f|
        make_thumb f unless FileTest.exist?(f.sub('gallery', 'gallery_thumbnail'))
        idx = f.match('\d+')[0]
        pic = Hash.new(0)
        pic['thumb_url'] = "/assets/gallery_thumbnail/#{cat}/#{idx}.jpg"
        pic['image_url'] = "/assets/gallery/#{cat}/#{idx}.jpg"
        pic['sort'] = idx.to_i
        pic
      end.sort_by { |s| s['sort'] }
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
