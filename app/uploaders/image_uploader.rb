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
  version :thumb do
    process resize_to_fill: [200, 200]
  end

  version :thumb_s do
    process resize_to_fill: [100, 100]
  end

  version :thumb_xs do
    process resize_to_fill: [50, 50]
  end

  version :avatar do
    process resize_to_fill: [150, 150]
  end

  version :avatar_xs do
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
