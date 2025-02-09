  $ touch "one_two_three.txt"
  $ touch "four five.txt"
  $ powermv "(.*)\.txt" "{{_1|CamelCase}}.txt" * -x
  Ready to perform move operations
  four five.txt -> FourFive.txt
  one_two_three.txt -> OneTwoThree.txt
  $ ls
  FourFive.txt
  OneTwoThree.txt
  $ powermv "(.*)\.txt" "{{_1|snake_case}}.txt" * -x
  Ready to perform move operations
  FourFive.txt -> four_five.txt
  OneTwoThree.txt -> one_two_three.txt
  $ ls
  four_five.txt
  one_two_three.txt
  $ powermv "(.*)\.txt" "{{_1|camel_case}}.txt" * -x
  Ready to perform move operations
  four_five.txt -> FourFive.txt
  one_two_three.txt -> OneTwoThree.txt
  $ ls
  FourFive.txt
  OneTwoThree.txt
  $ powermv "(.*)\.txt" "{{_1|SnakeCase}}.txt" * -x
  Ready to perform move operations
  FourFive.txt -> four_five.txt
  OneTwoThree.txt -> one_two_three.txt
  $ ls
  four_five.txt
  one_two_three.txt
  $ powermv "(.*)\.txt" "{{_1|CamelCase}}.txt" * -x
  Ready to perform move operations
  four_five.txt -> FourFive.txt
  one_two_three.txt -> OneTwoThree.txt
  $ powermv "(.*)\.txt" "{{_1|SpaceCase}}.txt" * -x
  Ready to perform move operations
  FourFive.txt -> four five.txt
  OneTwoThree.txt -> one two three.txt
  $ ls
  four five.txt
  one two three.txt
  $ powermv "(.*)\.txt" "{{_1|snake_case}}.txt" * -x
  Ready to perform move operations
  four five.txt -> four_five.txt
  one two three.txt -> one_two_three.txt
  $ ls
  four_five.txt
  one_two_three.txt
  $ powermv "(.*)\.txt" "{{_1|space_case}}.txt" * -x
  Ready to perform move operations
  four_five.txt -> four five.txt
  one_two_three.txt -> one two three.txt
  $ ls
  four five.txt
  one two three.txt
