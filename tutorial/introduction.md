## Introduction

A register machine contains an unlimited set of registers, each of which can store any natural number $n \in \mathbb{N}$

Register machine programs consist of labelled instructions. There are three available instructions:

- ($R^+ \to L'$) increments the value in $R$, then jumps to the instruction labelled $L'$
- ($R^- \to L', L''$) decrements the value in $R$ if positive, then jumps to the instruction labelled $L'$. Otherwise, jumps directly $L''$, leaving $R$ as $0$.
- ($Halt$) terminates the program

An example program, which we will see later in more detail, is the addition program. When run on initial register values of $R_1 = x, R_2 = y$, it halts with $R_0 = x + y$.

$
L_0: R_1^- \to L_1, L_6 \\
L_1: R_2^- \to L_2, L_4 \\
L_2: R_0^+ \to L_3 \\
L_3: R_3^+ \to L_1 \\
L_4: R_3^- \to L_5, L_0 \\
L_5: R_2^+ \to L_4 \\
L_6: Halt
$