  $ echo 1 > file-1.txt
  $ echo 2 > file-2.txt
  $ ls
  file-1.txt
  file-2.txt
# move files to a directory
# and change padding
  $ powermv 'file-(\d).txt' 'files/file-{{_1|pad(3)}}.txt' * -x
  Building move operations set
  Analyzing move operations set
  Ordering move operations
  Ready to perform move operations
  file-1.txt -> files/file-001.txt
  file-2.txt -> files/file-002.txt
  $ ls
  files
  $ ls files
  file-001.txt
  file-002.txt
# move files from a directory
# to their own directory
  $ powermv 'files/file-(\d+).txt' 'file{{_1}}/file.txt' */* -x
  Building move operations set
  Analyzing move operations set
  Ordering move operations
  Ready to perform move operations
  files/file-001.txt -> file1/file.txt
  files/file-002.txt -> file2/file.txt
  $ ls
  file1
  file2
  files
  $ ls files
  $ ls file1
  file.txt
  $ ls file2
  file.txt
  $ cat file1/file.txt
  1
  $ cat file2/file.txt
  2
# move directories into an existing directory
  $ powermv 'file(\d+)' 'files' * -x
  Building move operations set
  Analyzing move operations set
  NOTE: 'files' is a directory that is given as the output for 2 move operations.  (glob)
  It is assumed that you want to move all inputs (including directores) into this  (glob)
  directory.
  Ordering move operations
  Ready to perform move operations
  file1 -> files
  file2 -> files
  $ ls
  files
  $ ls files
  file1
  file2
  $ ls files/file1
  file.txt
  $ ls files/file2
  file.txt
  $ cat files/file1/file.txt
  1
  $ cat files/file2/file.txt
  2
# move directories into a new directory
  $ powermv 'files/file(\d+)' 'files/new' */* -x
  Building move operations set
  Cannot move a directory (files/file1) to a file (files/new). Did you forget a  (glob)
  '/' at the end of the output name?
  [1]
  $ powermv 'files/file(\d+)' 'files/new/' */* -x
  Building move operations set
  Analyzing move operations set
  NOTE: 'files/new' is a directory that is given as the output for 2 move  (glob)
  operations. It is assumed that you want to move all inputs (including  (glob)
  directores) into this directory.
  Ordering move operations
  Ready to perform move operations
  files/file1 -> files/new
  files/file2 -> files/new
  $ ls files
  new
  $ ls files/new
  file1
  file2
  $ cat files/new/file1/file.txt
  1
  $ cat files/new/file2/file.txt
  2
# rename directories into a new directory
  $ rm files file1 file2 -rf
  $ mkdir dir1 dir2
  $ echo 1 > dir1/file.txt
  $ echo 2 > dir2/file.txt
  $ powermv 'dir(\d)' 'dir{{_1|pad(2)}}/' dir* -x
  Building move operations set
  Analyzing move operations set
  Ordering move operations
  Ready to perform move operations
  dir1 -> dir01
  dir2 -> dir02
  $ ls
  dir01
  dir02
  $ ls dir01
  file.txt
  $ ls dir02
  file.txt
