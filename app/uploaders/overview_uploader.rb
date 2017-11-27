class OverviewUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  include CarrierWave::ImageOptimizer
  include CarrierWave::MiniMagick


  # process :store_dimension #Hvad er billedets højde og bredde?
  # Choose what kind of storage to use for this uploader:
  storage :fog
  # storage :fog
  # Override the directory where uploaded files will be stored.

  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "nye/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  process :resize_to_width

  def resize_to_width
    resize_to_limit 250, 182
  end


  # process :optimize_image

  # def optimize_image
  #   manipulate! do |img|
  #     img.format("jpg") do |c|
  #       c.trim
  #       c.auto_orient
  #       # c.rotate      "#{options[:rotate]}" if options.has_key?(:rotate)
  #       # c.resize      "#{options[:resolution]}>" if options.has_key?(:resolution)
  #       # c.resize      "#{options[:resolution]}<" if options.has_key?(:resolution)
  #       # c.push        '+profile'
  #       # c.+           "!xmp,*"
  #       # c.profile     "#{Rails.root}/lib/color_profiles/sRGB_v4_ICC_preference_displayclass.icc"
  #       # c.colorspace  "sRGB"
  #     end
  #     img
  #   end


  # end
  # def scale

  # process :scale_width [1200, nil] if
  # version :medium do
  #   process resize_to_fill: [270, 162]
  # end

  # version :thumb do
  #   process resize_to_fill: [168, 120]
  # end


  # def er_oversigt_bil?(file)
  #   if file.original_filename.include? "START" #scope in image.rb
  #     return true
  #   end
  # end

  #   if file && model
  #   if image_width > image_height
  #   process resize_to_fit: [1200, nil]
  #   else
  #   process resize_to_fit: [nil, 900]
  #   end
  #   binding.pry
  # end

  # def scale
  #   if model["width"] > model["height"]
  #     resize_to_fit: [1200, nil]
  #   else
  #     resize_to_fit: [nil, 900]
  #   end
  # end

  # Create different versions of your uploaded files:

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(jpg jpeg gif png tif tiff gif JPEG JPG GIF PNG TIF TIFF)
  end

  # def filename
  #   "#{file.original_filename.split(".").shift}.jpg"
  # end

  # process :optimize
end
