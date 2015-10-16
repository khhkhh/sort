@slow = [:selection, :bubble, :bubble2, :bubble3]
@fast = [:mergesort]
@algorithms = @slow + @fast

@arrays = [
  [],
  [4],
  [-2, 4, 0, -7, 123],
  [4, 1],
  [1, 2, 3],
  [1, -9, -5, -8, 7, 2, -10, 8, 7, 1],
  [15, 79, -47, 94, -69, 64, -88, -24, 42, -30, -59, -72, 8, 47, -68, 84, 38, 12, -69, 66, -2, 45, -10, 80, -17, 46, -43, 81, 87, -2, 53, 68, -63, -72, 11, -66, 5, 13, 54, 3, 50, 9, -10, -80, 4, 93, -52, -29, -58, 39, 70, 24, 33, -46, 4, 99, -38, 36, 77, -73, -46, 78, 47, -3, -53, 38, -17, 38, -65, 66, 91, 85, 22, 0, 6, 35, -49, -100, 15, -47, -17, 61, 0, -51, 10, 30, 68, 34, -54, 65, 31, -94, -3, -91, -65, -93, 15, 47, 13, -8, 7, -88, -19, 77, -100, -29, 28, -19, -52, -25, -3, 92, -31, -45, -67, -79, 23, 81, -24, 37, -28, 84, 73, -53, 73, -31, 21, -48, 31, -3, -72, 11, -49, 84, -100, -81, -1, 35, -85, -14, 36, 72, 9],
  (proc { arr = []; 532.times { arr << rand(1234) - 634 }; arr }).call
]

def selection(a)
  n = a.length
  (0...n).each do |i|
    min = a[i]
    min_index = i
    (i + 1...n).each do |j|
      if a[j] < min
        min = a[j]
        min_index = j
      end
    end
    a[i], a[min_index] = a[min_index], a[i]
  end
  a
end

def bubble(a)
  n = a.length
  def swap(a, n)
    swapped = false
    cont = (0..n-2).each do |i|
      if a[i] > a[i+1]
        a[i], a[i+1] = a[i+1], a[i]
        swapped = true
        break i + 1
      end
    end
    
    return swapped if cont.is_a? Range
    
    (cont..n-2).each do |i|
      if a[i] > a[i+1]
        a[i], a[i+1] = a[i+1], a[i]
      end
    end
    swapped
  end
  
  while swap(a, n)
  end
  
  a
end

def bubble2(a)
  n = a.length
  swapped = true
  while swapped
    swapped = false
    cont = (0..n-2).each do |i|
      if a[i] > a[i+1]
        a[i], a[i+1] = a[i+1], a[i]
        swapped = true
        break i + 1
      end
    end
    next if cont.is_a? Range
    (cont..n-2).each do |i|
      if a[i] > a[i+1]
        a[i], a[i+1] = a[i+1], a[i]
      end
    end
  end
  a
end

def bubble3(a)
  n = a.length
  return a if n < 2
  counter = 0
  while true
    i = 0
    i += 1 while i <= n - 2 && a[i] <= a[i + 1]
    break if i == n - 1
    while i <= n - 2 - counter
      if a[i] > a[i+1]
        a[i], a[i+1] = a[i+1], a[i]
      end
      i += 1
    end
    counter += 1
  end
  a
end

def mergesort(a, l = 0, r = a.length)
  def merge(a, l, m, r)
#     ll= left.length
#     rr = right.length
    li = l
    ri = m
    result = []
    while li < m && ri < r
      if a[li] < a[ri]
        result << a[li]
        li += 1
      else
        result << a[ri]
        ri += 1
      end
    end
    if li < m
      a[-1 - m + li..-1] = a[li
    a[l...result.length] = result
  end
  
  return if (r - l) < 2
  m = (l + r) / 2
  left = mergesort(a, l, m)
  rignt = mergesort(a, m, r)
  merge(a, l, m, r)
end


def assert_equal(a, b)
  return if a == b
  p a
  p "isn't equal to"
  p b
end

def check(algorithm, array)
  assert_equal (send algorithm, array.clone), array.sort
end

def check_all
  @algorithms.each do |alg|
    puts alg
    @arrays.each do |arr|
      check(alg, arr)
    end
  end
end

def speed_test(algs)
  array = (proc { arr = []; 10000.times { arr << rand(1234) - 634 }; arr }).call
  
  algs.each do |alg|
    p alg
    arr = array.clone
    start = Time.now
    send alg, arr
    endd = Time.now
    p endd - start
    assert_equal arr, array.sort
  end
end

check_all

# speed_test(@algorithms)
# :selection
# 4.974951633
# :bubble
# 18.489501424
# :bubble2
# 18.19742308
# :bubble3
# 10.910939094

# speed_test(@fast)
