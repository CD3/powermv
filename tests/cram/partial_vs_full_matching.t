  $ touch file-1.txt file-2.txt
  $ ls
  file-1.txt
  file-2.txt
  $ powermv '(\d)' '{{_1|pad(3)}}' * -x
  Building move operations set
  Analyzing move operations set
  Ordering move operations
  Ready to perform move operations
  file-1.txt -> file-001.txt
  file-2.txt -> file-002.txt
  $ ls
  file-001.txt
  file-002.txt
  $ mkdir dir1 dir2
  $ powermv '(\d)' '{{_1|pad(3)}}' *
  Building move operations set
  Analyzing move operations set
  Ordering move operations
  Ready to perform move operations
  dir1 -> dir001
  dir2 -> dir002
  file-001.txt -> file-00001.txt
  file-002.txt -> file-00002.txt
  $ powermv 'dir(\d)' 'd{{_1|pad(3)}}' *
  Building move operations set
  Analyzing move operations set
  Ordering move operations
  Ready to perform move operations
  dir1 -> d001
  dir2 -> d002
  $ rm * -r
  $ touch file-1-0.txt file-1-1.txt file-1-2.txt
  $ powermv '(\d)-(\d)' '{{_1}}.{{_2}}' *
  Building move operations set
  Analyzing move operations set
  Ordering move operations
  Ready to perform move operations
  file-1-0.txt -> file-1.0.txt
  file-1-1.txt -> file-1.1.txt
  file-1-2.txt -> file-1.2.txt
  $ powermv '(\d)' '{{_1|pad(2)}}' *
  Building move operations set
  Analyzing move operations set
  Ordering move operations
  Ready to perform move operations
  file-1-0.txt -> file-01-0.txt
  file-1-1.txt -> file-01-1.txt
  file-1-2.txt -> file-01-2.txt
  $ powermv '(\d)\.txt' '{{_1|pad(2)}}.txt' *
  Building move operations set
  Analyzing move operations set
  Ordering move operations
  Ready to perform move operations
  file-1-0.txt -> file-1-00.txt
  file-1-1.txt -> file-1-01.txt
  file-1-2.txt -> file-1-02.txt

