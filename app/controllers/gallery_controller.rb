class GalleryController < ApplicationController
  def index
    path = './app/assets/images/gallery/'
   
    @pics = Dir["#{path}**/1.jpg"].collect do |f|
      t = f.sub('gallery', 'gallery_thumbnail')
      make_thumb f unless FileTest.exist?(t)
      pic = Hash.new(0)
      cat = f.sub(path, '').sub('/1.jpg', '')
      pic['image_url'] = t.sub('./app', '').sub('/images', '')
      pic['link'] = "/gallery/#{cat}"
      pic['category'] = cat.capitalize
      pic
    end
    
  end
  def indexx
    require 'RMagick'
    #include 'Magick'
    path = './app/assets/images/gallery/'
    @categories = Hash.new(0)
    
    @pics = Dir["#{path}**/*.*"].collect do |f|
      t = f.sub('gallery', 'gallery_thumbnail')
      unless FileTest.exist?(t)
        img = Magick::Image::read(f).first
        img = img.thumbnail(0.36)
        img.write(t)
      end
      
      a = f.sub(path, '').split('/')
      @categories[a[0].capitalize] += 1
      ["/" + a.join('/'), a[0]]
    end
    @categories.each do |k, v| 
      @categories[k] = "#{k} (#{v})"
    end
    @categories['All'] = "All (#{@pics.size})"
    @categories = Hash[@categories.sort]
    
  end
    
  def show
    cat = params[:cat]
    if params[:id]
      id = params[:id]
      @pic = "/assets/gallery/#{cat}/#{id}.jpg"
      render 'image'  
    else
      path = "./app/assets/images/gallery/#{cat}/*.jpg"
      @pics = Dir[path].collect do |f|
        t = f.sub('gallery', 'gallery_thumbnail')
        i = t.sub('./app/assets/images', '/assets')
        l = f.sub('./app/assets/images', '').chomp('.jpg')
        id = l.split('/')[3].to_i
        make_thumb f unless FileTest.exist?(t)
        pic = Hash.new(0)
        pic['image_url'] = i
        pic['link'] = l
        pic['sort'] = id
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




