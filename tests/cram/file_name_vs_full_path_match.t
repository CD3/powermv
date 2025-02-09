  $ mkdir -p dir-1/subdir-1/ dir-2/subdir-2/
  $ touch dir-1/subdir-1/file-1.txt dir-2/subdir-2/file-2.txt
  $ powermv '(\d)' '{{_1|pad(3)}}' */*/*
  Ready to perform move operations
  dir-1/subdir-1/file-1.txt -> dir-001/subdir-1/file-1.txt
  dir-2/subdir-2/file-2.txt -> dir-002/subdir-2/file-2.txt
  $ powermv '(\d)' '{{_1|pad(3)}}' */*/* -n
  Ready to perform move operations
  dir-1/subdir-1/file-1.txt -> dir-1/subdir-1/file-001.txt
  dir-2/subdir-2/file-2.txt -> dir-2/subdir-2/file-002.txt
  $ rm * -r
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
