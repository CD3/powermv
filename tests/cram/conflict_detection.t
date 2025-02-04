  $ echo file-1.txt > file-1.txt
  $ echo file-2.txt > file-2.txt
  $ ls
  file-1.txt
  file-2.txt
  $ powermv 'file-(\d).txt' 'file-2.txt' file-3.txt
  Building move operations set
  Analyzing move operations set
  Errors detected with move set.
    Input 'file-3.txt' does not exist.
  [1]
  $ ls
  file-1.txt
  file-2.txt
  $ powermv 'file-(\d).txt' 'file-2.txt' file-3.txt file-3.txt -x
  Building move operations set
  Analyzing move operations set
  Errors detected with move set.
    Input 'file-3.txt' does not exist.
  [1]
  $ ls
  file-1.txt
  file-2.txt
  $ powermv 'file-(\d).txt' 'file-{{_1|inc}}.txt' *
  Building move operations set
  Analyzing move operations set
  Ready to perform move operations
  file-1.txt -> file-2.txt
  file-2.txt -> file-3.txt
