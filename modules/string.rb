#encoding:utf-8

s = "
unit1
good;好
bad；;好
"

def get_structured_data(text)
  data = []
  error_lines = {}

  curr_unit = nil
  unit_dic = {}
  text.split(/\r|\n|\r\n/).each_with_index do |line, num|

    if line.nil? or line.strip == ""
      puts "empty line"
      next;
    end

    line = line.strip
    parts = line.split(/;|；/)

    if parts.size == 2
      puts "#{curr_unit}: #{parts[0]} #{parts[1]}"
      item = {"word"=>parts[0],"mean_cn"=>parts[1]}
      unit_dic[curr_unit] << item
    elsif parts.size == 1

      unit = parts[0].downcase
      if (unit =~ /unit\d+/) != nil
        curr_unit = unit.sub("unit","").to_i
        unit_dic[curr_unit] = []
      else
        error_lines[num]=line
      end
    else
      error_lines[num]=line
    end
  end

  return unit_dic,error_lines
end

ret = get_structured_data(s)
puts ret[0].inspect
puts ret[1].inspect