  $ echo 1 > file-1.txt
  $ echo 2 > file-2.txt
  $ echo 3 > file-3.txt
  $ ls
  file-1.txt
  file-2.txt
  file-3.txt
  $ powermv 'file-(\d).txt' 'file-{{_1|inc}}.txt' *
  Ready to perform move operations
  file-3.txt -> file-4.txt
  file-2.txt -> file-3.txt
  file-1.txt -> file-2.txt
  $ powermv 'file-(\d).txt' 'file-{{_1|inc}}.txt' * -x
  Ready to perform move operations
  file-3.txt -> file-4.txt
  file-2.txt -> file-3.txt
  file-1.txt -> file-2.txt
  $ ls
  file-2.txt
  file-3.txt
  file-4.txt
  $ cat file-2.txt
  1
