class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file

  ######## DIR
  def store_dir
    "images/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
  end

  def default_url
    "default/" + [version_name, "default.jpg"].compact.join('_')
  end

  ######## PROCESS
  process :validate_dimensions
  process scale: [300, 300]

  def scale(width, height)
    resize_to_fill(width, height)
  end

  ######## VERSIONS
  version :s do
    process resize_to_fill: [100, 100]
  end

  version :index_1 do
    process resize_to_fill: [75, 75]
  end

  version :index_2 do
    process resize_to_fill: [175, 175]
  end

  version :thumb_lg do
    process resize_to_fill: [125, 125]
  end

  version :thumb do
    process resize_to_fill: [100, 100]
  end

  version :thumb_s do
    process resize_to_fill: [50, 50]
  end

  version :thumb_xs do
    process resize_to_fill: [35, 35]
  end

  ######## EXTENSIONS
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
