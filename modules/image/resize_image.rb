require "rubygems"
require "mini_magick"
require "pp"

class BczMagick
  def self.resize_image(source_path,dest_path,standard_size=[400,300])
    origin_img = MiniMagick::Image.open(source_path)
    old_size = [origin_img[:width],origin_img[:height]]
    new_size = calcute_new_size(old_size,standard_size)
    origin_img.resize(new_size.join("x"))
    origin_img.write dest_path
  end

  def self.resize_add_blank_background(source_path,dest_path,standard_size=[400,300])
    origin_img = MiniMagick::Image.open(source_path)
    old_size = [origin_img[:width],origin_img[:height]]
    new_size = calcute_new_size(old_size,standard_size)
    origin_img.combine_options do |c|
      c.resize(new_size.join("x"))
      c.background "#FFFFFF"
      c.gravity "North"
      c.extent "#{standard_size.join("x")}"
    end
    origin_img.write dest_path
  end

  def self.composite_start_from_left(bg_path,layers,positions,dest_path)
    img_bg = MiniMagick::Image.open(bg_path)
    extname = File.extname(bg_path)
    layers.each_with_index do |layer_path,index|
      layer_position = positions[index]
      img_layer = MiniMagick::Image.open(layer_path)
      img_bg = img_bg.composite(img_layer,extname) do |c|
        c.geometry "+#{layer_position.first}+#{layer_position.last}"
      end
    end
    img_bg.write dest_path
  end


  def self.calcute_new_size(old_size,standard_size)
    old_width,old_height = old_size.first,old_size.last
    s_width,s_height = standard_size.first,standard_size.last
    rate_info = (old_width.to_f / old_height.to_i)*100.round
    s_rate = (s_width.to_f / s_height.to_i)*100.round
    
    if rate_info < s_rate
      new_w = (s_height * old_width.to_f / old_height.to_f).round
      [new_w,s_height]
    else
      new_h = (s_width * old_height.to_f / old_width.to_f).round
      [s_width,new_h]
    end
  end


end


# pp BczMagick.composite_start_from_left("/Users/freda/Desktop/beef.jpg",["/Users/freda/Desktop/test.jpg"],[[45,406]],"/Users/freda/Desktop/beef4.jpg")



