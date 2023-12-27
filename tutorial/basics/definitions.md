# Definitions

## Configurations

A ***register machine configuration*** is a tuple $(\ell_i, r_0, r_1, \ldots) $ consisting of the current instruction label, and the current contents of its registers. 

---

## Computations

***Register machine computation*** can then be described by a series of configurations, where successive configurations are reached by executing the relevant instruction. This computation thus allows us to track how the values of registers are modified by instructions at each label, and how the program flow is manipulated.

We can classify computation as either halting or non-halting. A ***halting computation*** is some finite sequence of configurations $c_0, c_1, \ldots, c_m$, where the instruction label in $c_m$ refers to a $Halt$. In contrast, a ***non-halting*** computation is some infinite sequence of configurations.

We can fully map out the computation of the example addition program from the [examples](tutorial/examples/programs.md). In this computation, the program is run on initial values $R_1 = 1, R_2 = 2$.

$
\begin{array}{|c|c|c|c|c|}
\hline
C_i & L_i & R_0 & R_1 & R_2 \\
\hline
C_1 & 0 & 0 & 1 & 2 \\
C_2 & 1 & 0 & 0 & 2 \\
C_3 & 0 & 1 & 0 & 2 \\
C_4 & 2 & 1 & 0 & 2 \\
C_5 & 3 & 1 & 0 & 1 \\
C_6 & 2 & 2 & 0 & 1 \\
C_7 & 3 & 2 & 1 & 0 \\
C_8 & 2 & 3 & 0 & 0 \\
C_9 & 4 & 3 & 0 & 0 \\
\hline
\end{array}
$

---

## Computability

To clarify our usage of register machines, we need to more clearly define how we will use them to compute a function. This will then allow us to talk about which functions can actually be computed on a register machine.

Since the registers can only store natural numbers, any parameters and results of a register machine program must be naturals. Specifically, we are concerned with register machine programs producing a single result in $R_0$, and taking their parameters from the other registers $R_1, R_2, \ldots$.

Formally, we can then consider any $n$-ary partial function $f: \N^n \to \N$. Such a function is ***register machine computable*** if, and only if, we can define some register machine $M$ that, when run on the initial configuration $R_0 = 0, R_1 = x_1, R_2 = x_2, \ldots, R_n = x_n$ and all other registers zeroed, halts with $R_0 = y$ if and only if $f(x_1, \ldots, x_n) = y$. $M$ must therefore have at least $n + 1$ registers to compute an $n$-ary function. Additionally, for any inputs $\langle x_1, \ldots, x_n \rangle \in \mathbb{N}^n$ for which $f$ is not defined, the program must not halt.
