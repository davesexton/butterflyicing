class GalleryImage < ActiveRecord::Base
  attr_accessible :tag_id, :image, :file_name
  attr_accessor  :file_type

  belongs_to :tag

  validates :file_type, allow_blank: false, unless: :persisted?, format: {
    with: /^image\/\w*(jpeg|png)\w*/,
    message: '--- you can only upload JPEG image files' #, allow_nil: true
  }

  before_destroy do |r|
    File.delete(r.image_file_path)
    File.delete(r.thumbnail_file_path)
  end

  def image_path
    "/images/gallery_images/#{file_name}"
  end

  def thumbnail_path
    "/thumbnails/#{file_name}"
  end

  def image_file_path
    Rails.root.join('public', 'images', 'gallery_images', file_name)
  end

  def image=(file)

    self.file_type = file.content_type.chomp

    if file && self.valid?
      require 'RMagick'

      self.file_name = "#{Time.now.to_i}.jpg"

      file.rewind
      file = Magick::Image::from_blob(file.read).first
      file.change_geometry!('640x480') { |cols, rows, img|
        file.resize!(cols, rows)
      }
      file.write(Rails.root.join('public', 'images', 'gallery_images', file_name))
    end
  end

end
