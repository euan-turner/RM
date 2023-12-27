# Introduction

A Minsky register machine is an idealised form of computation. As such, restrictions on the number of available registers, and the contents of those registers, are removed.

---

A Minsky register machine comprises an unlimited set of registers, each capable of storing any natural number $n \in \mathbb{N}$. Each register $R_i$ is subscripted to uniquely identify it.

---

A register machine program then consists of a series of instructions, labelled to determine their ordering and placement. Like registers, labels $L_i$ are subscripted to uniquely identify them.

Minsky register machines provide just three simple instructions:

- $L_i: R_n^+ \to L_j$ increments the value in $R_n$ and then jumps to the instruction labelled $L_j$.
- $L_i: R_n^- \to L_j, L_k$ decrements the value in $R_n$ if it positive and then jumps to the instruction labelled $L_j$. Otherwise, it jumps directly to $L_k$ and leaves $R_n$ unchanged.
- $Halt$ terminates execution of the program.

---

An example program, which we will see later in more detail, is the addition program. When run on initial register values of $R_1 = x, R_2 = y$, it halts with $R_0 = x + y$.

$
L_0: R_1^- \to L_1, L_2 \\
L_1: R_0^+ \to L_0 \\
L_2: R_2^- \to L_3, L_4 \\
L_3: R_0^+ \to L_2 \\
L_4: Halt
$
