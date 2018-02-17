def bubblesort(array)
  n= array.length
  loop do
    swapped = false
    (n-1).times do |i|
      if array[i]> array[i+1]
        array[i],array[i+1]=array[i+1],array[i]
        swapped = true
      end

    end
  break if not swapped
  end
  array
end
arr =[7,6,8,9,0,3,2,1,5,4,6]
puts"Das Array die zum sortieren ist :"
print arr
puts""
puts"Das Array nachdem sortieren :"
p bubblesort(arr)
