  $ touch file-1.txt file-2.txt
  $ powermv '(\d)' '{{_1|inc(2)}}' * -x
  Building move operations set
  Analyzing move operations set
  Ordering move operations
  Ready to perform move operations
  file-1.txt -> file-3.txt
  file-2.txt -> file-4.txt
