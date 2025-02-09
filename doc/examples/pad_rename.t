  $ echo 1 > file-1.txt
  $ echo 2 > file-2.txt
  $ echo 3 > file-3.txt
  $ powermv 'file-(\d).txt' 'data_file-{{_1|pad(2)}}.txt' * -x
  Ready to perform move operations
  file-1.txt -> data_file-01.txt
  file-2.txt -> data_file-02.txt
  file-3.txt -> data_file-03.txt
  $ ls
  data_file-01.txt
  data_file-02.txt
  data_file-03.txt
