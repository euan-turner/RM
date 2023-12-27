# Program Examples

## Adder

When run on $R_1 = x, R_2 = y$, this program terminates with $R_0 = x + y, R_1 = 0, R_2 = 0$.

$
L_0: R_1^- \to L_1, L_2 \\
L_1: R_0^+ \to L_0 \\
L_2: R_2^- \to L_3, L_4 \\
L_3: R_0^+ \to L_2 \\
L_4: Halt
$

## Subtracter

When run on $R_1 = x, R_2 = y$, this program terminates with $R_0 = x - y, R_1 = 0, R_2 = 0$ if $x >= y$. Otherwise, the program halts with $R_0 = 0, R_1 = 0, R_2 = 0$.

$
L_0: R_1^- \to L_1, L_2 \\
L_1: R_0^+ \to L_0 \\
L_2: R_2^- \to L_3, L_4 \\
L_3: R_0^- \to L_2, L_4 \\
L_4: Halt
$