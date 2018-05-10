# warum hier eine klasse deklariert
class Array
  # was macht hier def ganz genau
  def quicksort
    return [] if empty?
    # die funktionen verstehen und was machen die ganz genau
    pivot= delete_at(rand(size))
    left,right = partition(&pivot.method(:>))
    # warum hier stern benutzen ist es wie zeiger bei c sprache ??
    return *left.quicksort,pivot,*right.quicksort
    # def ende
  end
    # class ende 
  end
  arr =[5,4,9,6,3,2,1,8,7,0]
  p arr.quicksort
