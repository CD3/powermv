  $ mkdir dir1
  $ echo hi > file-1.txt
  $ echo bye > file-2.txt
  $ echo hi > dir1/file-3.txt
  $ echo hi > dir1/file-4.txt
  $ powermv inc $(find . -type f|sort)
  Ready to perform move operations
  dir1/file-3.txt -> dir2/file-3.txt
  dir1/file-4.txt -> dir2/file-4.txt
  file-2.txt -> file-3.txt
  file-1.txt -> file-2.txt
  $ powermv inc $(find . -type f|sort) -n
  Ready to perform move operations
  dir1/file-4.txt -> dir1/file-5.txt
  file-2.txt -> file-3.txt
  dir1/file-3.txt -> dir1/file-4.txt
  file-1.txt -> file-2.txt
