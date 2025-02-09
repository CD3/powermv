  $ mkdir -p dir/level1/level2/
  $ touch dir/level1/level2/file-1.txt
  $ touch dir/level1/level2/file-2.txt
  $ touch dir/level1/level2/datafile-1.txt
  $ touch dir/level1/level2/datafile-2.txt
  $ powermv '(\d)' '{{_1|inc}}' dir/*/*/*
  Ready to perform move operations
  dir/level1/level2/datafile-1.txt -> dir/level2/level2/datafile-1.txt
  dir/level1/level2/datafile-2.txt -> dir/level2/level2/datafile-2.txt
  dir/level1/level2/file-1.txt -> dir/level2/level2/file-1.txt
  dir/level1/level2/file-2.txt -> dir/level2/level2/file-2.txt
  $ powermv '(\d)' '{{_1|inc}}' dir/*/*/* -n
  Ready to perform move operations
  dir/level1/level2/datafile-2.txt -> dir/level1/level2/datafile-3.txt
  dir/level1/level2/file-2.txt -> dir/level1/level2/file-3.txt
  dir/level1/level2/datafile-1.txt -> dir/level1/level2/datafile-2.txt
  dir/level1/level2/file-1.txt -> dir/level1/level2/file-2.txt
  $ powermv 'file-(\d)\.txt' 'FILE-{{_1|inc}}.txt' dir/*/*/* -n
  Ready to perform move operations
  dir/level1/level2/datafile-1.txt -> dir/level1/level2/dataFILE-2.txt
  dir/level1/level2/datafile-2.txt -> dir/level1/level2/dataFILE-3.txt
  dir/level1/level2/file-1.txt -> dir/level1/level2/FILE-2.txt
  dir/level1/level2/file-2.txt -> dir/level1/level2/FILE-3.txt
  $ powermv '^file-(\d)\.txt' 'FILE-{{_1|inc}}.txt' dir/*/*/* -n
  Ready to perform move operations
  dir/level1/level2/file-1.txt -> dir/level1/level2/FILE-2.txt
  dir/level1/level2/file-2.txt -> dir/level1/level2/FILE-3.txt
