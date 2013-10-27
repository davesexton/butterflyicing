class GalleryController < ApplicationController
  skip_before_filter :authorize

  def index

    redirect_to gallery_path(Tag.first.id) unless params[:id]
#    tg = Tag.includes(:gallery_images)
#            .group('tags.id')
#            .having('COUNT(gallery_images.id) > 0').map{|t| t.tag_group_id}
#    @tag_groups = TagGroup.find(tg)

    @tags = Tag.includes(:gallery_images)
               .group('tags.id')
               .having('COUNT(gallery_images.id) > 0')

    @tag_groups = TagGroup.find(@tags.map{|t| t.tag_group_id})

    @gallery_images = GalleryImage.where('tag_id = ?', params[:id])

  end

end
