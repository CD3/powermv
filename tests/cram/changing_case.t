  $ touch "one_two_three.txt"
  $ touch "four five.txt"
  $ powermv "(.*)\.txt" "{{_1|CamelCase}}.txt" * -x
  Ready to perform move operations
  four five.txt -> FourFive.txt
  one_two_three.txt -> OneTwoThree.txt
