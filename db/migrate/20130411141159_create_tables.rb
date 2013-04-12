class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |user|
      user.string :name, :email, :password
    end
    create_table :galleries do |gallery|
      gallery.string :name
      gallery.references :user
    end
    create_table :photos do |photo|
      photo.string :original_path, :thumbnail_path
      photo.references :gallery
      photo.string :file
    end
  end
end
