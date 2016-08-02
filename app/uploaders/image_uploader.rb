# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "images/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process scale: [900, 99999]

  def scale(width, height)
    resize_to_limit(width, height)
  end

  # VERSIONES
  version :avatar do
    process resize_to_fill: [300, 300]
  end

  version :avatar_md do
    process resize_to_fill: [195, 195]
  end

  version :avatar_s do
    process resize_to_fill: [150, 150]
  end

  version :thumb do
    process resize_to_fill: [100, 100]
  end

  version :thumb_md do
    process resize_to_fill: [75, 75]
  end

  version :thumb_s do
    process resize_to_fill: [50, 50]
  end


  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def default_url
    # ActionController::Base.helpers.asset_path("images/default_avatar.jpg")
    "/images/default_avatar/" + [version_name, "default_avatar.jpg"].compact.join('_')
  end

end
