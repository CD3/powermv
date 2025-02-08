Make some files...
  $ echo file-1.txt > file-1.txt
  $ echo file-2.txt > file-2.txt
  $ ls
  file-1.txt
  file-2.txt
Arguments that match the input pattern but do not exist should cause failure.
  $ powermv 'file-(\d).txt' 'file-2.txt' file-3.txt
  Building move operations set
  Analyzing move operations set
  Errors detected in move set
    Input 'file-3.txt' does not exist
  [1]
Passing same argument multiple times should give the same error.
  $ powermv 'file-(\d).txt' 'file-2.txt' file-3.txt file-3.txt
  Building move operations set
  Analyzing move operations set
  Errors detected in move set
    Input 'file-3.txt' does not exist
  [1]
Trying to excute the move should give same error _and_ not do anything.
  $ powermv 'file-(\d).txt' 'file-2.txt' file-3.txt -x
  Building move operations set
  Analyzing move operations set
  Errors detected in move set
    Input 'file-3.txt' does not exist
  [1]
  $ ls
  file-1.txt
  file-2.txt
If multiple input _files_ map to the same _output_ file, it's an error we should not do anything.
  $ powermv 'file-(\d).txt' 'file-3.txt' file-1.txt file-2.txt
  Building move operations set
  Analyzing move operations set
  Errors detected in move set
    Multiple move operations produce the same output
    Output: file-3.txt
      file-1.txt -> file-3.txt
      file-2.txt -> file-3.txt
    Output must be a directory if multiple move operations point to it
  [1]
  $ ls
  file-1.txt
  file-2.txt
No errors
  $ powermv 'file-(\d).txt' 'file-{{_1|inc}}.txt' *
  Building move operations set
  Analyzing move operations set
  Ordering move operations
  Ready to perform move operations
  file-2.txt -> file-3.txt
  file-1.txt -> file-2.txt
No errors and execute moves
  $ powermv 'file-(\d).txt' 'file-{{_1|inc}}.txt' * -x
  Building move operations set
  Analyzing move operations set
  Ordering move operations
  Ready to perform move operations
  file-2.txt -> file-3.txt
  file-1.txt -> file-2.txt
  $ ls
  file-2.txt
  file-3.txt
Again, multiple input files mapping to same output file is an error
  $ powermv 'file-(\d).txt' 'file.txt' * -x
  Building move operations set
  Analyzing move operations set
  Errors detected in move set
    Multiple move operations produce the same output
    Output: file.txt
      file-2.txt -> file.txt
      file-3.txt -> file.txt
    Output must be a directory if multiple move operations point to it
  [1]
Clear everything and make some more files...
  $ rm * -r
  $ echo file-11.txt > file-11.txt
  $ echo file-12.txt > file-12.txt
  $ echo file-21.txt > file-21.txt
  $ echo file-22.txt > file-22.txt
  $ ls
  file-11.txt
  file-12.txt
  file-21.txt
  file-22.txt
If multiple input files are mapped to one out file, an error for each output file should be reported.
  $ powermv 'file-(\d)\d.txt' 'file-{{_1}}.txt' *
  Building move operations set
  Analyzing move operations set
  Errors detected in move set
    Multiple move operations produce the same output
    Output: file-1.txt
      file-11.txt -> file-1.txt
      file-12.txt -> file-1.txt
    Output: file-2.txt
      file-21.txt -> file-2.txt
      file-22.txt -> file-2.txt
    Output must be a directory if multiple move operations point to it
  [1]
Files that would not be renamed should be skipped
  $ powermv '.' '{{_0}}' *
  Building move operations set
  No files to move
  [1]
