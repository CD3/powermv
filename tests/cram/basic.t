  $ touch file-1.txt
  $ ls
  file-1.txt
  $ powermv 'file-(\d).txt' 'file-{{_1|pad(3)}}.txt' *
  Ready to perform move operations
  file-1.txt -> file-001.txt
  $ ls
  file-1.txt
  $ powermv 'file-(\d).txt' 'file-{{_1|pad(3)}}.txt' * -x
  Ready to perform move operations
  file-1.txt -> file-001.txt
  $ ls
  file-001.txt
  $ powermv 'file-(\d).txt' 'file-{{_1|inc(1)|pad(2)}}.txt' * -x
  [1]
  $ ls
  file-001.txt
  $ powermv 'file-(\d+).txt' 'file-{{_1|inc(1)|pad(2)}}.txt' * -x
  Ready to perform move operations
  file-001.txt -> file-02.txt
  $ ls
  file-02.txt

