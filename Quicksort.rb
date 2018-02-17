class Array
  def quicksort
    return [] if empty?
    pivot= delete_at(rand(size))
    left,right = partition(&pivot.method(:>))
    return *left.quicksort,pivot,*right.quicksort
  end
  end
  arr =[5,4,9,6,3,2,1,8,7,0]
  p arr.quicksort
