Make some files
  $ echo 1 > file-1.txt
  $ echo 2 > file-2.txt
  $ ls
  file-1.txt
  file-2.txt
Rename files, changing the padding in thier index number
  $ powermv 'file-(\d).txt' 'file-{{_1|pad(2)}}.txt' * -x
  Ready to perform move operations
  file-1.txt -> file-01.txt
  file-2.txt -> file-02.txt
  $ ls
  file-01.txt
  file-02.txt
Move files to a directory _and_ change padding
  $ powermv 'file-(\d\d).txt' 'files/file-{{_1|pad(3)}}.txt' * -x
  Ready to perform move operations
  file-01.txt -> files/file-001.txt
  file-02.txt -> files/file-002.txt
  $ ls
  files
  $ ls files
  file-001.txt
  file-002.txt
Move files from a directory to their _own_ directory
  $ powermv 'files/file-(\d+).txt' 'file{{_1}}/file.txt' */* -x
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
Move directories into an existing directory
  $ powermv 'file(\d+)' 'files' * -x
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
Move directories into a new directory
  $ powermv 'files/file(\d+)' 'files/new' */* -x
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
Rename directories 
  $ rm * -r
  $ mkdir dir1 dir2
  $ echo 1 > dir1/file.txt
  $ echo 2 > dir2/file.txt
  $ powermv 'dir(\d)' 'dir{{_1|pad(2)}}' dir* -x
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
Move files to a directory 
  $ rm * -r
  $ ls
  $ echo 1 > file1.txt
  $ echo 2 > file2.txt
  $ powermv 'file(\d).txt' 'dir{{_1|pad(3)}}' *
  Ready to perform move operations
  file1.txt -> dir001
  file2.txt -> dir002
  $ powermv 'file(\d).txt' 'dir{{_1|pad(3)}}/' * -x
  Ready to perform move operations
  file1.txt -> dir001/file1.txt
  file2.txt -> dir002/file2.txt
  $ ls
  dir001
  dir002
  $ ls dir001
  file1.txt
  $ cat dir001/file1.txt
  1
  $ ls dir002
  file2.txt
  $ cat dir002/file2.txt
  2

