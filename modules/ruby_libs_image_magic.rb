#encoding:utf-8
require 'mini_magick'

def standard_size(width,height,standard_width=300)
  width,height = width.to_i,height.to_i
  new_width = width > standard_width ? standard_width : width
  new_height = ((new_width.to_f / width) * height).round()
  [new_width,new_height]
end

def standard_size_by_height(width,height,standard_height=300)
  width,height = width.to_i,height.to_i
  new_height = height > standard_height ? standard_height : height
  new_width = ((new_height.to_f / height) * width).round()
  [new_width,new_height]
end

def fix_for_weixin(force_change=false)
  dest_dir = File.join(File.dirname(File.dirname(absolute_path)),"df_for_weixin")
  out_file = File.join(dest_dir,"#{self.file_name.split(".").first}.jpg")
  return out_file if File.exist?(out_file) && force_change == false

  temp_dest_file = File.join(File.dirname(out_file),self.file_name)
  img = MiniMagick::Image.open(absolute_path)
  cur_width = img[:width]
  cur_height = img[:height]
  size = [cur_width, cur_height]
  puts size.join("x")

  if cur_height > 200
    size = standard_size_by_height(cur_width,cur_height,200)
  elsif cur_width > 360
    size = standard_size(cur_width,cur_height,360)
  end
  img.resize(size.join("x"))
  img.write temp_dest_file

  bg_file = Rails.root + "public/images/weixin_bg.jpg"
  `composite -gravity center #{temp_dest_file} #{bg_file} #{out_file}`
  File.delete(temp_dest_file)

  out_file
end