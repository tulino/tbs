# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include Cloudinary::CarrierWave

  process convert: 'jpg'
  process tags: ['tbs']
  process :face_detection

  version :standard do
    process eager: true
    process resize_to_fill: [100, 150, :north]
  end

  version :show do
    process resize_to_fill: [180, 240]
  end

  version :member_list do
    process resize_to_fill: [35, 35]
  end

  version :thumbnail do
    process resize_to_fill: [25, 25]
  end

  def public_id
    secure_token
  end

  # Store cropped image
  def face_detection
    'width: 180, height: 240, crop: thumb, gravity: face'
  end

  def secure_token
    require 'securerandom'
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) || model.instance_variable_set(var, Digest::SHA256.hexdigest(SecureRandom.hex(10)))
  end
end
