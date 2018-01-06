class LinkImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::ImageOptimizer
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fill: [540, 300] # Samme størrelse som Iframe/youtube-visningen
  end

end
