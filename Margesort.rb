# was macht def gan genau
def marge_sort(array)
  if array.length <=1
    array
  else
    mid = (array.length/2).floor
    left = marge_sort(array[0..mid-1])
    right = marge_sort(array[mid..array.length])
    merge(left,right)
    # if ende
end
# def ende
end
def merge(left,right)
  if left.empty?
    right
  elsif right.empty?
    left
  elsif left.first < right.first
    [left.first]+ merge(left[1..left.length],right)
  else
    [right.first]+merge(left,right[1..right.length])
  end
end
arr =[5,4,9,6,3,2,1,8,7,0]
p marge_sort(arr)
