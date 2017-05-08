class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  ######## DIR
  def store_dir
    "images/#{model.imageable_type.underscore}/#{model.imageable_id}/#{mounted_as}/#{model.id}"
  end

  def default_url
    "/images/default/" + [version_name, "default_avatar.jpg"].compact.join('_')
  end

  ######## PROCESS
  process :validate_dimensions
  process scale: [3500, 9999]

  def scale(width, height)
    resize_to_limit(width, height)
  end

  ######## VERSIONS
  version :gallery_lg do
    process resize_to_limit: [1500, 1000]
  end

  version :gallery do
    process resize_to_limit: [750, 750]
  end

  version :thumb_lg do
    process resize_to_fill: [120, 120]
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

  ######## EXTENSIONS
  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
