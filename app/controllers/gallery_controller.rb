class GalleryController < ApplicationController
  skip_before_filter :authorize

  def index
    cat = params[:cat] ? params[:cat] : 'birthday'

    @cats_selected = cat
    @cats = get_gallery_categories

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

end
