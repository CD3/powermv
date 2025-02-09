  $ echo 1 > file-1.txt
  $ echo 2 > file-2.txt
  $ echo 3 > file-3.txt
  $ powermv 'file-(\d).txt' 'dir-{{_1}}/file.txt' * -x
  Ready to perform move operations
  file-1.txt -> dir-1/file.txt
  file-2.txt -> dir-2/file.txt
  file-3.txt -> dir-3/file.txt
  $ ls
  dir-1
  dir-2
  dir-3
  $ head */*
  ==> dir-1/file.txt <==
  1
  
  ==> dir-2/file.txt <==
  2
  
  ==> dir-3/file.txt <==
  3
