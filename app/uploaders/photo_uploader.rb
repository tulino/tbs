class PhotoUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :file
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg png)
  end

  def filename
    "#{secure_token}.#{file.extension}" if original_filename.present?
  end

  version :large do
    process resize_to_fill: [850, 1200]
  end

  version :show do
    process resize_to_fill: [100, 150]
  end

  protected

  def secure_token
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, Digest::SHA256.hexdigest(SecureRandom.hex(10)))
  end
end
