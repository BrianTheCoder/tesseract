# encoding: utf-8
require 'carrierwave/processing/mini_magick'
require 'carrierwave/processing/mime_types'
require 'digest/md5'

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include CarrierWave::MimeTypes

  process :set_content_type

  if Rails.env.production?
    storage :fog
  else
    storage :file
  end
  
  version :full do
    process resize_to_limit: [780, 10_000]
  end

  version :thumb do
    process resize_to_fill: [276, 165]
  end

  def store_dir
    "uploads/#{model.id}"
  end

  def md5
    return @_md5 if @_md5
    chunk = model.file
    @md5 = Digest::MD5.hexdigest(chunk.read)
  end

  def filename
    @name ||= "#{md5}#{File.extname(super)}" if super
  end
end