# Encodings

In order to reason about The Halting Problem, we need to be able to have one register machine program inspect another. To do this, we must be able to express a program as a single, unique natural number, so that it can be stored in a register. We will therefore generate a [Gödel numbering](https://en.wikipedia.org/wiki/G%C3%B6del_numbering) for register machine programs.

A register machine program is just a list of instructions, and so to uniquely encode a program we need to be able to uniquely encode each possible instruction, and then uniquely encode a list of natural numbers. As we'll see below, a unique encoding of pairs of natural numbers is sufficient to uniquely encode a list of them

## Encoding Pairs

We can define two separate encodings of pairs. The reason for the distinction will become evident later.

Firstly, we can define an encoding $\N \times \N \to \N$ which forms a bijection.

- $\langle x, y \rangle \triangleq 2^x (2y + 1)$

Secondly, we can define an encoding $\N \times \N \to \N^+$ which forms a bijection. $\N^+ = \{ n \in \N | n \neq 0\}$

- $\ll x, y \gg \triangleq 2^x (2y + 1)$

The intuition behind each of these encodings being bijections lies in their binary representations.

- $0\textbf{b}\langle x, y \rangle = | 0\textbf{b}y | 0 | 1 \ldots 1| $, with $x$ 1s.
- $0\textbf{b}\ll x, y \gg = | 0\textbf{b}y | 1 | 0 \ldots 0| $ with $x$ 0s.

```haskell
-- <x, y>
encPair1 :: Integral a => a -> a -> a 
encPair1 x y = encPair2 x y - 1

-- <<x, y>>
encPair2 :: Integral a => a -> a -> a 
encPair2 x y = (2 ^ x) * (2 * y + 1)
```

## Encoding Lists

If we think about lists using their Haskell-like constructors, then there is a natural application of the encoding of pairs to fold a list down into a single encoding.

A list $\ell \in [\N]$ may have two constructors:

- The empty constructor $[] \in [\N]$.
- The cons constructor $x : \ell' \in [\N]$, where $x \in \N, \ell' \in [\N]$.

We can therefore define the encoding of a list $\ulcorner \ell \urcorner$ on these two cases:

$
\ulcorner [] \urcorner \triangleq 0 \\
\ulcorner x : \ell \urcorner \triangleq \ll x, \ulcorner \ell \urcorner \gg
$

```haskell
encList :: Integral a => [a] -> a
encList [] = 0
encList (x:xs) = encPair2 x (encList xs)
```

Simplifying with a fold we have

```haskell
encList :: Integral a => [a] -> a 
encList = foldr encPair2 0
```

Here is the first part of the justification for having two different pair encodings. $\ll x, y \gg$ does not map any pair to $0$, and so the empty list can be safely encoded to $0$ here. If we just had $\langle x, y \rangle$, then the encodings $\ulcorner [] \urcorner$ and $\ulcorner [0] \urcorner$ would both be $0$.

## Encoding Instructions

The final step before being able to encode an entire program is to be able to encode an individual instructions. We can define different encoding functions for each instruction form, while guaranteeing that they do not clash.

- $\ulcorner R_i^+ \to L_j \urcorner \triangleq \; \ll 2i, j \gg $
- $\ulcorner R_i^- \to L_j, L_k \urcorner \triangleq \; \ll 2i + 1, \langle j, k \rangle \; \gg$
- $\ulcorner Halt \urcorner \triangleq \; 0$

```haskell
encInstr :: Instr -> Integer
encInstr (Inc i j) = fromIntegral (encPair2 (2 * i) j)
encInstr (Dec i j k) = fromIntegral (encPair2 (2 * i + 1) (encPair1 j k))
encInstr Halt = 0
```

Using $\ll x, y \gg$ for addition and subtraction reserves $0$ for the $Halt$ instruction. Addition and subtraction can then be differentiated by using the $i\text{th}$ even and odd numbers respectively as the first parameter. The second part of the justification for two different pair encodings is here. If $\ll j, k \gg$ were used instead of $\langle j, k \rangle$ for the subtraction instruction, then our encoding of instructions would not be a bijection. This is because there would be no subtraction instruction that would lead to $\ll 2i+1, 0 \gg$ being evaluated.

## Encoding Programs

A program can then be encoded as a list of instructions, to form a bijection $\textit{Prog} \to \N$. This forms our Gödel numbering for register machine programs.

$\ulcorner P \urcorner \triangleq \ulcorner [\ulcorner body_0 \urcorner, \ldots, \ulcorner body_n \urcorner ] \urcorner$

The Haskell implementation uses ```snd``` to discard the labels numbering each instruction.

```haskell
encProg :: Prog -> Integer 
encProg = encList . (map (encInstr . snd))
```
