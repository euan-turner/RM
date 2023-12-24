# Definitions

The remainder of this tutorial will be up towards being able to talk about The Halting Problem in terms of register machines. To reach that point, we first need to establish some definitions.

A ***register machine configuration*** $(\ell_i, r_0, r_1, \ldots) $ consists of the current instruction label, and the current contents of its registers. ***Register machine computation*** can then be described by a series of configurations, where successive configurations are reached by executing the relevant instruction.

We can classify computation as either halting or non-halting. A ***halting computation*** is some finite sequence of configurations $c_0, c_1, \ldots, c_m$, where the instruction label in $c_m$ refers to a $Halt$. In contrast, a ***non-halting*** computation is some infinite sequence of configurations.

We can describe the computation of the addition program from the [introduction](tutorial/introduction.md) run on initial values $R_1 = 1, R_2 = 2$ as below:

| $L_i$    | $R_0$    | $R_1$    | $R_2$    |
|----------|----------|----------|----------|
| 0        | 0        | 1        | 2        |
| 1        | 0        | 0        | 2        |
| 0        | 1        | 0        | 2        |
| 2        | 1        | 0        | 2        |
| 3        | 1        | 0        | 1        |
| 2        | 2        | 0        | 1        |
| 3        | 2        | 1        | 0        |
| 2        | 3        | 0        | 0        |
| 4        | 3        | 0        | 0        |

Finally, we need to be able to talk more generally about computing any function over the natural numbers in a register machine. In the addition example, the two arguments are initially stored in register $R_1$ and $R_2$, and the result is stored in the register $R_0$ once the program halts.

This can be extended for any $n$-ary partial function $f$. We call a partial function $f \in \mathbb{N}^n \to \mathbb{N}$ ***register machine computable*** if we can define a register machine $M$ that, when run on the initial configuration $R_0 = 0, R_1 = x_1, R_2 = x_2, \ldots, R_n = x_n$ and all other registers zeroed, halts with $R_0 = y$ if and only if $f(x_1, \ldots, x_n) = y$. $M$ must therefore have at least $n + 1$ registers to compute an $n$-ary function. Additionally, for any inputs $\langle x_1, \ldots, x_n \rangle \in \mathbb{N}^n$ for which $f$ is not defined, the program must not halt.