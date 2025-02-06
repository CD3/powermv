  $ echo file-1.txt > file-1.txt
  $ echo file-2.txt > file-2.txt
  $ ls
  file-1.txt
  file-2.txt
  $ powermv 'file-(\d).txt' 'file-2.txt' file-3.txt
  Building move operations set
  Analyzing move operations set
  Errors detected in move set
    Input 'file-3.txt' does not exist
  [1]
  $ powermv 'file-(\d).txt' 'file-2.txt' file-3.txt file-3.txt
  Building move operations set
  Analyzing move operations set
  Errors detected in move set
    Input 'file-3.txt' does not exist
  [1]
  $ ls
  file-1.txt
  file-2.txt
  $ powermv 'file-(\d).txt' 'file-2.txt' file-3.txt -x
  Building move operations set
  Analyzing move operations set
  Errors detected in move set
    Input 'file-3.txt' does not exist
  [1]
  $ powermv 'file-(\d).txt' 'file-2.txt' file-1.txt file-2.txt
  Building move operations set
  Analyzing move operations set
  Errors detected in move set
    Multiple move operations produce the same output
    Output: file-2.txt
      file-1.txt -> file-2.txt
      file-2.txt -> file-2.txt
    Output must be a directory if multiple move operations point to it
  [1]
  $ ls
  file-1.txt
  file-2.txt
  $ powermv 'file-(\d).txt' 'file-{{_1|inc}}.txt' *
  Building move operations set
  Analyzing move operations set
  Ordering move operations
  Ready to perform move operations
  file-2.txt -> file-3.txt
  file-1.txt -> file-2.txt
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

# Building move operations set
# Analyzing move operations set
# Errors detected in move set
#   Multiple move operations produce the same output
#   Output: file.txt
#     file-12.txt -> file-1.txt
#     file-13.txt -> file-1.txt
#   Output: file-2.txt
#     file-22.txt -> file-2.txt
#     file-23.txt -> file-2.txt
# Output must be a directory if multiple move operations point to it.
# [1]
