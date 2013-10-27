class AddFileNameToGalleryImages < ActiveRecord::Migration
  def change
    add_column :gallery_images, :file_name, :string
  end
end
