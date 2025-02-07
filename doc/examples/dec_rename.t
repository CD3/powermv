  $ touch file-2.txt file-3.txt file-4.txt
  $ powermv 'file-(\d).txt' 'file-{{_1|dec}}.txt' * -x
  Building move operations set
  Analyzing move operations set
  Ordering move operations
  Ready to perform move operations
  file-2.txt -> file-1.txt
  file-3.txt -> file-2.txt
  file-4.txt -> file-3.txt
