module StoreHelper
  def tr_pattern(number)
   pattern = Array.new
   for i in 0..10
    pattern.push (4*i+1)
   end
   pattern.each do |row|
    return true if row==number
   end
   return false
  end

  def tr_done_pattern(number)
   pattern = Array.new
   for i in 1..10
     pattern.push (4*i)   
   end  
   pattern.each do |row|
     return true if row==number
   end
  return false
  end
end

