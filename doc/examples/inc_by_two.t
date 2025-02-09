  $ touch file-1.txt file-2.txt
  $ powermv '(\d)' '{{_1|inc(2)}}' * -x
  Ready to perform move operations
  file-1.txt -> file-3.txt
  file-2.txt -> file-4.txt
