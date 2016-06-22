#encoding:utf-8



def answer(steps=[1,3,4],counts = 5,cur_steps=[],count = 0)

  if counts <= 0
    puts cur_steps.inspect;
    return;
  end

  tmp_count = count;
  steps.each do |step|
    count=tmp_count+1;
    if cur_steps.size >= count
      cur_steps = cur_steps[0...count-1]
    end
    cur_steps << step;

    if counts-step < 0
      return;
    end

    answer(steps,counts-step,cur_steps,count)
  end

end

answer([1,3,4],10)


North = 0
South = 1
West = 2
East = 3

def get_next_pos(x,y,direction)
  newX = x
  newY = y

  case direction
    when North then
      newY = y-1;
    when South then
      newY = y+1
    when West then
      newX = x-1
    when East then
      newX = x+1
    else
      raise Exception.new("direction error");
    end

  return [newX,newY]
end

startPos = [0,0]
Island = 0
Visited = 2
Water = 1

def travel(data,width=4, height=4,pos)
  return if data[pos[0]][pos[1]]  == Visited or data[pos[0]][pos[1]]  == Water
  data[pos[0]][pos[1]] = Visited  if data[pos[0]][pos[1]] == Island

  [North,East,South,West].each do |direction|
    next_pos =  get_next_pos(pos[0],pos[1],direction)
    if next_pos[0]>=0 and next_pos[0] < width  and next_pos[1] >=0 and next_pos[1] < height
      content = data[next_pos[0]][next_pos[1]]
      if content == Island
         travel(data, width,height,[next_pos[0],next_pos[1]])
      end

    end
  end
end

def find_all_islands_scope(data,width,height)
  x = 0
  y = 0
  count = 0
  while(x < width)
    y = 0
    while(y < height)
      if data[x][y] == Island
         travel(data,width,height,[x,y])
         count+=1
      end
      y+=1
    end
    x+=1
  end
  return count
end

data = [[0,1,0,1],
        [1,1,0,1],
        [0,1,0,0],
        [1,1,0,1]]

island_count = find_all_islands_scope(data,4,4)
puts "有#{island_count}个岛群"



def bigNumMultiply(a,b)
  pre_row = nil

  a.reverse!
  b.reverse!
  a.each_with_index do |na,indexa|
    ret1 = []

    b.each_with_index do |nb,index|
      ret1 << na*nb
    end

    puts ret1.inspect

    i = 0;
    while(i < ret1.size)
      cur_num = ret1[i]%10
      add_num = ret1[i]/10
      ret1[i]= cur_num
      if add_num > 0
        if i == ret1.size - 1
          ret1 << add_num
        else
          ret1[i+1] = add_num
        end
      end
      puts ret1.inspect
      i+=1
    end

    ret1.reverse!
    puts ret1.inspect
    puts "----"

    if pre_row.nil?
        pre_row = ret1
        next
    end

    puts "pre_row #{pre_row.inspect}"

    start_pos = indexa;
    n = 0
    size  =  ret1.size
    while(n < size)
      start_pos+n < pre_row.size ? mx = pre_row[start_pos+n] : (mx = 0; ret1.insert(0,0);)
      my = ret1[n]
      m_cur_num = (mx+my) / 10
      m_add_num = (mx+my) % 10
      pre_row[n] = m_cur_num
      pre_row[n+1] = m_add_num
      n+=1
    end


  end
end


a = [1,2,3,4]
b = [1,2,3,4]

bigNumMultiply(a,b)