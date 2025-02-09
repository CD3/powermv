  $ echo 1 > file-1.txt
  $ echo 2 > file-2.txt
  $ echo 3 > file-3.txt
  $ ls
  file-1.txt
  file-2.txt
  file-3.txt
  $ powermv inc *
  Ready to perform move operations
  file-3.txt -> file-4.txt
  file-2.txt -> file-3.txt
  file-1.txt -> file-2.txt
  $ powermv inc * -c 2
  Ready to perform move operations
  file-2.txt -> file-4.txt
  file-3.txt -> file-5.txt
  file-1.txt -> file-3.txt
  $ powermv inc * -c 2 -p 2
  Ready to perform move operations
  file-1.txt -> file-03.txt
  file-2.txt -> file-04.txt
  file-3.txt -> file-05.txt

  $ powermv inc * -c -1
  Ready to perform move operations
  file-1.txt -> file-0.txt
  file-2.txt -> file-1.txt
  file-3.txt -> file-2.txt
