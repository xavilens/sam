class AvatarUploader < CarrierWave::Uploader::Base

  include CarrierWave::MiniMagick

  storage :file

  def store_dir
    "images/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "default_avatar/" + [version_name, "default.jpg"].compact.join('_')
    # ActionView::Helpers::AssetUrlHelper.image_path("default_avatar/" + [version_name, "default.jpg"].compact.join('_'))
    # ActionController::Base.helpers.asset_path("default_avatar/" + [version_name, "default.jpg"].compact.join('_'))
    # asset_path("default_avatar/" + [version_name, "default.jpg"].compact.join('_'))
    # "/images/default_avatar/" + [version_name, "default.png"].compact.join('_')
    # "/images/default_avatar/" + [version_name, "default.jpg"].compact.join('_')
  end

  process scale: [300, 300]

  def scale(width, height)
    resize_to_fill(width, height)
  end

  # VERSIONES

  version :avatar_s do
    process resize_to_fill: [100, 100]
  end

  version :index_avatar_1 do
    process resize_to_fill: [75, 75]
  end

  version :index_avatar_2 do
    process resize_to_fill: [175, 175]
  end

  version :thumb_avatar do
    process resize_to_fill: [100, 100]
  end

  version :thumb_avatar_s do
    process resize_to_fill: [50, 50]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
