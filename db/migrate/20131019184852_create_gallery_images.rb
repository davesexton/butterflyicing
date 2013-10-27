class CreateGalleryImages < ActiveRecord::Migration
  def change
    create_table :gallery_images do |t|
      t.integer :tag_id

      t.timestamps
    end
  end
end
