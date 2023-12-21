module Gadget (remapProg, Gadget, RegMap, InstrMap) where

import RM (Instr(..), Prog, RLabel, ILabel, toProg)
import Data.Maybe

-- Gadgets
-- (program, scratch registers, exit labels)
type Gadget = (Prog, [RLabel], [ILabel])

-- A gadget should function as a standalone register machine program
-- When constructed, it will assume access sole access to all registers,
-- and will start from instruction label 0.
-- The caller should remap all parameter registers
-- A gadget's definition contains a list of scratch registers it uses,
-- which the caller should also remap
-- A gadget's definition contains a list of exit labels, whose meaning
-- should be documented
-- Gadgets should guarantee that all scratch registers are zeroed before exit

type RegMap = [(RLabel, RLabel)]
type InstrMap = [(ILabel, ILabel)]
-- The caller should construct a regmap which it will use to remap registers
-- This remapping will be applied to all registers in the program,
-- so the caller should take care to only remap scratch registers
-- from the gadget
-- All instruction labels will also be remapped

remapProg :: Prog -> RegMap -> InstrMap -> Prog 
remapProg [] _ _ = []
remapProg ((i, Inc r l):pr) rm im =
  (i', Inc r' l') : remapProg pr rm im
  where 
    i' = remap im i 
    r' = remap rm r 
    l' = remap im l
remapProg ((i, Dec r l1 l2):pr) rm im =
  (i', Dec r' l1' l2') : remapProg pr rm im
  where 
    i' = remap im i 
    r' = remap rm r 
    l1' = remap im l1 
    l2' = remap im l2  
remapProg ((i, Halt):pr) rm im = (i', Halt) : remapProg pr rm im 
  where 
    i' = remap im i

remap :: Eq a => [(a, a)] -> a -> a 
remap rm r = case lookup r rm of 
  Nothing -> r 
  Just r' -> r' 



