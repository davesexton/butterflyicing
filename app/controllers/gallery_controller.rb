class GalleryController < ApplicationController
  def index
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

end
