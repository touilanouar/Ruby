puts "Hallo"
Arr = [1,3,2,7,5,0]
puts Arr
print Arr
a,b = 3,2
c = a+b
puts "die Summe ist #{c}"
# Prints a text-based progress bar representing 0 to 100 percent. Each "="
# sign represents 5 percent.
0.step(100, 5) do |i|
  printf("\rProgress: [%-20s]", "=" * (i/5))
  sleep(0.5)
end
puts
# Print 1 to 100 percent in place in the console using "dynamic output"
# technique
1.upto(100) do |i|
  printf("\rPercentage: %d %", i)
  sleep(0.1)
end
puts
