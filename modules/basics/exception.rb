#encoding:utf-8


def exception1
  raise Exception.new("exception1")
end


def exception2
  begin
    exception1
  rescue Exception=>e
    raise Exception.new(e)
  end
end

exception2