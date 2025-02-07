  $ echo 1 > file-1.txt
  $ echo 2 > file-2.txt
  $ echo 3 > file-3.txt
If a move operation would overwrite a file that is not
an input to another move operation, then we should
fail.
  $ powermv '(\d)' '{{_1|inc}}' file-2.txt -x
  Building move operations set
  Analyzing move operations set
  Errors detected in move set
    Output 'file-3.txt' already exists and is not the input for another move  (glob)
  operation. Which means it would be overwritten. If this is intentional, use  (glob)
  --overwrite.
  [1]
  $ ls
  file-1.txt
  file-2.txt
  file-3.txt
  $ powermv '(\d)' '{{_1|inc}}' file-2.txt -x --overwrite
  Building move operations set
  Analyzing move operations set
  Ordering move operations
  Ready to perform move operations
  file-2.txt -> file-3.txt
  $ ls
  file-1.txt
  file-3.txt
  $ cat file-1.txt
  1
  $ cat file-3.txt
  2
