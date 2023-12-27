# Minsky Register Machines in Haskell

Welcome to this Minsky Register Machines tutorial. This repository is intended to serve as an educational resource for understanding Minsky register machines as a theoretical model of computation.

## Overview

Minsky register machines are simple yet powerful abstract machines introduced by Marvin Minsky in the 1960s. They are easier to grasp than Turing machines, while exhibiting the exact same computational power.

The first part of this tutorial will focus on understanding the basics of register machines, how they work, and some examples of simple register machine programs.

The second part of this tutorial will then discuss how we can use register machines to reason about The Halting Problem.

## Tutorial Contents

### Part 1 - The Basics

1. [**Introduction**](tutorial/basics/introduction.md): Understand the fundamentals of Minsky register machines.

2. [**Program Graphs**](tutorial/basics/graphs.md): Visualise register machine programs to clearly illustrate their purpose.

3. [**Definitions**](tutorial/basics/definitions.md): Delve into the essential definitions underlying the usage of register machines as a model of computation.

4. [**Program Gadgets**](tutorial/basics/gadgets1.md): Use gadgets to simplify register machine program representations, and more efficiently build up large programs.

### Part 2 - The Halting Problem

1. [**Overview**](tutorial/halting/overview.md): Define The Halting Problem and map out an approach to reasoning about a solution.

2. [**Encodings**](tutorial/halting/encodings.md): Understand the bijections that allow the Gödel number of a program to be calculated.

3. [**Program Gadgets**](tutorial/halting/gadgets2.md): Create register machine program gadgets that are useful in the context of reasoning about The Halting Problem

4. [**The Universal Register Machine**](tutorial/halting/urm.md): Piece together the Universal Register Machine, collating together content from throughout the tutorial.

5. [**The Halting Problem**](tutorial/halting/solution.md): Construct a proof as to the decidability of The Halting Problem, and understand its imlications.

### Examples

1. [**Programs**](tutorial/examples/programs.md): Find example programs used and referenced throughout the tutorial.

2. [**Gadgets**](tutorial/examples/gadgets.md): Find example gadgets use and referenced throughout the tutorial.


## Following the Tutorial

To get started with the tutorial, read the [Introduction](tutorial/basics/introduction.md), then follow through the sections in order. Throughout the tutorial, snippets of Haskell code will be used to support and further illustrate certain concepts. The code in full can be found in the accompanying Haskell files within the repository.

Happy learning!

