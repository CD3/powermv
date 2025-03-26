  $ mkdir dir1
  $ echo hi > file-1.txt
  $ echo bye > file-2.txt
  $ echo Hi > dir1/file-3.txt
  $ echo Bye > dir1/file-4.txt
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
  $ powermv inc $(find . -type f|sort) -n -x
  Ready to perform move operations
  dir1/file-4.txt -> dir1/file-5.txt
  file-2.txt -> file-3.txt
  dir1/file-3.txt -> dir1/file-4.txt
  file-1.txt -> file-2.txt
  $ ls | sort
  dir1
  file-2.txt
  file-3.txt
  $ ls dir1 | sort
  file-4.txt
  file-5.txt
  $ powermv inc $(find . -type f|sort) -x
  Ready to perform move operations
  dir1/file-4.txt -> dir2/file-4.txt
  dir1/file-5.txt -> dir2/file-5.txt
  file-3.txt -> file-4.txt
  file-2.txt -> file-3.txt
  $ ls | sort
  dir1
  dir2
  file-3.txt
  file-4.txt
  $ ls dir1 | sort
  $ ls dir2 | sort
  file-4.txt
  file-5.txt
  $ cat file-3.txt
  hi
  $ cat file-4.txt
  bye
  $ cat dir2/file-4.txt
  Hi
  $ cat dir2/file-5.txt
  Bye
