class GalleryController < ApplicationController
  skip_before_filter :authorize

  def index

    redirect_to gallery_path(Tag.first.id) unless params[:id]

    @tags = Tag.includes(:gallery_images)
               .group('tags.id')
               .having('COUNT(gallery_images.id) > 0')

    @tag_groups = TagGroup.find(@tags.map{|t| t.tag_group_id})

    @gallery_images = GalleryImage.where('tag_id = ?', params[:id])

  end

  def thumbnails

    respond_to do |format|
      format.jpg do
        require 'RMagick'
        path = Rails.root.join('public', 'images','gallery_images')
        path = path.join("#{params[:image_name]}.jpg")
        if FileTest.exists?(path)
          img = Magick::Image::read(path).first
          img.crop_resized!(75, 75, Magick::NorthGravity)
          send_data img.to_blob, type: img.mime_type, disposition: :inline
        else
          format.any {render text: 'Not found', status: 404}
        end
      end
      format.any {render text: 'Not found', status: 404}
    end
  end

end
