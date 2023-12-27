# Gadgets

Gadgets are abstractions that allow us to more succinctly express and compose together register machine programs. There are a couple of useful principles to bear in mind when using gadgets:

- Gadgets may only have one entry wire, but may have several exit wires
- Input and output register of a gadget must be specified in the gadget's name
- Gadgets may use other registers, known as scratch registers, as part of their operation. These registers are assumed to be initially zero in most cases.

When defining a gadget, we must specify the program path from the entry wire, through internal instructions, and then out to each exit wire.

