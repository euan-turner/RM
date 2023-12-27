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

Too see some example programs putting these instructions to use, check out the [examples](../examples/programs.md)

