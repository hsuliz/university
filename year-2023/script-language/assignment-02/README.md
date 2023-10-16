# Assignment 2

1. The first pair prints a nicely formatted multiplication table from 1 to 9 and ignores any options and arguments.
2. The second pair prints a multiplication table from the first argument to the second argument, which is almost the
   same as the previous one, but controlled by the call arguments. If there are fewer than two arguments (meaning
   one :-) and it is numeric, we treat it as the upper limit (with a lower limit of 1). Without any arguments, it works
   like the previous script, showing the multiplication table from 1 to 9. Here, we need to check if the arguments are
   numeric and in the correct order. If either of the first two arguments is non-numeric, we exit with a nice comment.
   If there are more than two arguments, we ignore the remaining arguments. If the first two arguments are numeric and
   in the correct order, we print the multiplication table. If the order is incorrect (the first argument is greater
   than the second), we display the table from smaller to larger.
3. The third set of scripts does the same as the second but for any operation acceptable to the shell (seems to include
   at least +-*/% and exponentiation - which operator is used, but there may be other possibilities for binary
   operators?). Here, we check all three of the first arguments. One of them, placed arbitrarily, must be a known
   operator, and the other two must be numbers. We check both of these postulates, and if either of them is not met, we
   exit with the appropriate message and error code (1 if the argument is invalid, 2 if there is no valid operator). If
   the script finds these three arguments, it prints the table for that operation exactly in the order of the arguments,
   which may require displaying it from larger to smaller 