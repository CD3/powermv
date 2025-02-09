  $ mkdir dir1
  $ echo hi > dir1/file.txt
  $ ls
  dir1
  $ ls dir1
  file.txt
  $ cat dir1/file.txt
  hi
This will rename the directory
  $ powermv '(\d)' '{{_1|pad(2)}}' * -q -x
  $ ls
  dir01
  $ ls dir01
  file.txt
  $ cat dir01/file.txt
  hi
