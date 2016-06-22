setup do
  @target_sales = 100
  puts "set target_sales to #{@target_sales}"
end

setup do
  @mothly_sales = 2000
  puts "set mothly_sales to #{@mothly_sales}"
end

event "monthly sales are suspiciiously high" do
  @mothly_sales > @target_sales
end


event "monthly sales are abysmally low" do
  @mothly_sales < @target_sales
end