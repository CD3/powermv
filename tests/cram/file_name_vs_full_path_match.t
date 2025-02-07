  $ mkdir -p dir-1/subdir-1/ dir-2/subdir-2/
  $ touch dir-1/subdir-1/file-1.txt dir-2/subdir-2/file-2.txt
  $ powermv '(\d)' '{{_1|pad(3)}}' */*/*
  Building move operations set
  Analyzing move operations set
  Ordering move operations
  Ready to perform move operations
  dir-1/subdir-1/file-1.txt -> dir-001/subdir-1/file-1.txt
  dir-2/subdir-2/file-2.txt -> dir-002/subdir-2/file-2.txt
  $ powermv '(\d)' '{{_1|pad(3)}}' */*/* -n
  Building move operations set
  Analyzing move operations set
  Ordering move operations
  Ready to perform move operations
  dir-1/subdir-1/file-1.txt -> dir-1/subdir-1/file-001.txt
  dir-2/subdir-2/file-2.txt -> dir-2/subdir-2/file-002.txt
